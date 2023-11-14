class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :check_admin, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @products = current_user.products
    @total_stock = @products.sum(&:cantidad)
    @total_inv = @products.sum { |product| product.cantidad * product.precio }
    @pagy, @products = pagy(@products, items: 10)

    @remaining_stock = @products.sum do |product|
      sold_quantity = Sale.where(product: product).sum(:cantidad)
      [0, product.cantidad - sold_quantity].max
    end
  end

  def new
    @product = Product.new
    @sale = Sale.new
    @admin_products = Product.where(user_id: params[:admin_id])
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to products_path, notice: 'Producto creado exitosamente.'
    else
      render :new
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    if params[:admin_id].present?
      @admin_products = Product.where(user_id: params[:admin_id])
    else
      @admin_products = []
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  # acciones variadas

  def get_products
    @products = Product.where(user_id: params[:admin_id])
    render json: { products: @products.map { |p| { id: p.id, name: p.tipo_producto } } }
  end

  def stock
    @selected_admin = params[:admin_id].present? ? User.find(params[:admin_id]) : current_user
    @products = Product.where(user: @selected_admin)
    @admin1_products = User.find(1).products
    @admin2_products = User.find(2).products
  end

  def stgoiqq
    @selected_admin = params[:admin_id].present? ? User.find(params[:admin_id]) : current_user
    @products = Product.where(user_id: params[:admin_id])
    @admin1_products = User.find(1).products
    @admin2_products = User.find(2).products
  end


  private

  def product_params
    params.require(:product).permit(:tipo_producto, :precio, :cantidad, :precio_stgo, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def check_admin
    unless current_user && current_user.role == 'admin'
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción."
    end
  end
end
