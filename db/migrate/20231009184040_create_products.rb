class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :tipo_producto
      t.integer :precio
      t.integer :cantidad
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
