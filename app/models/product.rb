class Product < ApplicationRecord
  belongs_to :user
  has_many :sales, dependent: :destroy

  PRODUCTOS1= %w(MADERA CEMENTO LADRILLO ARENA GRAVA)
  PRODUCTOS2= %w(METAL PLASTICO VIDRIO CARTON PAPEL)
end
