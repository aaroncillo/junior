class SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    if @sale.save
      redirect_to products_path
    else
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
    redirect_to products_path
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
