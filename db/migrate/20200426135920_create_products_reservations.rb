class CreateProductsReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :products_reservations do |t|
      t.references :product, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
