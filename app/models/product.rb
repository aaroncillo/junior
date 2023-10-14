class Product < ApplicationRecord
  belongs_to :user
  has_many :sales, dependent: :destroy


  def remaining_quantity
    sold_quantity = Sale.where(product: self).sum(:cantidad)
    [0, cantidad.to_i - sold_quantity].max
  end
  PRODUCTOS1= %w(MADERA CEMENTO LADRILLO ARENA GRAVA)
  PRODUCTOS2= %w(METAL PLASTICO VIDRIO CARTON PAPEL)
end
