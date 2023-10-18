class SalesController < ApplicationController
  def index
    week_offset = params[:week_offset].present? ? params[:week_offset].to_i : 0
    # Ajustar el inicio y el fin de la semana para que sea de sábado a viernes
    start_of_week = (Time.now.beginning_of_week - 2.days).beginning_of_day - week_offset.weeks
    end_of_week = (Time.now.beginning_of_week + 4.days).end_of_day - week_offset.weeks

    # Formatear las fechas
    @formatted_start_of_week = start_of_week.strftime('%d/%m/%Y')
    @formatted_end_of_week = end_of_week.strftime('%d/%m/%Y')

    # obtener si estoy en la semana actual.
    @current_week = week_offset == 0

    if current_user.role == 'admin'
      admin_products_ids = Product.where(user: current_user).pluck(:id)
      @all_sales = Sale.where(product_id: admin_products_ids, fecha: start_of_week..end_of_week)
    else
      @all_sales = Sale.where(user: current_user, fecha: start_of_week..end_of_week)
    end

    @total_venta = @all_sales.joins(:product).sum('products.precio * sales.cantidad')
    @cantidad_vendida = @all_sales.sum(:cantidad)
    @pagy, @sales = pagy(@all_sales, items: 10)

    @total_venta = @sales.sum { |sales| sales.cantidad * sales.product.precio }
    @cantidad_vendida = @sales.sum(&:cantidad)

    # suma productos stgo

@total_venta_stgo = @sales.sum { |sales| sales.cantidad.to_i * sales.product.precio_stgo.to_i }

    # producto precio stgo  - precio
    @comision = @sales.sum { |sales| sales.cantidad.to_i * (sales.product.precio_stgo.to_i - sales.product.precio.to_i) }

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Listado de productos.xlsx"'
      }
    end
  end

  def new
    @sale = Sale.new
    if params[:admin_id].present?
      @admin_products = Product.where(user_id: params[:admin_id])
    else
      @admin_products = []
    end
  end


  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    if params[:product_id]
      @sale.product = Product.find(params[:product_id])
    end
    if @sale.save
      redirect_to sales_path
    else
      if params[:admin_id].present?
        @admin_products = Product.where(user_id: params[:admin_id])
      else
        @admin_products = []
      end
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @sale = Sale.find(params[:id])
  end

  def edit
    @sale = Sale.find(params[:id])
    if params[:admin_id].present?
      @admin_products = Product.where(user_id: params[:admin_id])
    else
      @admin_products = []
    end
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(sale_params)
      redirect_to sales_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    redirect_to sales_path
  end

  def fetch_products
    admin = User.find(params[:admin_id])
    products = admin.products
    render json: { products: products.map { |p| { id: p.id, tipo_producto: p.tipo_producto } } }
  end


  private

  def sale_params
    params.require(:sale).permit(:product_id,:cantidad, :fecha)
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
