class SalesController < ApplicationController
  def index
    if current_user.role == 'admin'
      admin_products_ids = Product.where(user: current_user).pluck(:id)
      @all_sales = Sale.where(product_id: admin_products_ids)
      @pagy, @sales = pagy(@all_sales, items: 5)
    else
      @all_sales = Sale.where(user: current_user)
      @pagy, @sales = pagy(@all_sales, items: 5)
    end

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
    @sale = Sale.find_by(id: params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(sale_params)
      redirect_to products_path
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
