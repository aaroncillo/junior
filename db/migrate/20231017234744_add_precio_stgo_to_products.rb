class AddPrecioStgoToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :precio_stgo, :integer
  end
end
