class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = current_user.products
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
    @product = Product.find_by(id: params[:id])
  end

  def update
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


  private

  def product_params
    params.require(:product).permit(:tipo_producto, :precio, :cantidad)
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