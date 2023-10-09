class ProductsController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @products = Product.includes(:sales).all
  end

  def new
    @product = Product.new
  end

  def create
   @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
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

  private

  def product_params
    params.require(:product).permit(:tipo_producto, :precio, :cantidad)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
