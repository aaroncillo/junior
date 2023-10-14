module ProductsHelper
  def product_options_with_stock(products)
    products.map do |product|
      ["#{product.tipo_producto} - Stock: #{product.cantidad}", product.id]
    end
  end
  def product_options_with_remaining_stock(products)
    products.map do |product|
      ["#{product.tipo_producto} - Stock: #{product.remaining_quantity}", product.id]
    end
  end
end
