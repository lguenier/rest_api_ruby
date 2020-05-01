class CreateProductsReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :products_reservations do |t|
      t.integer :reservation_id
      t.integer :quantity
      t.integer :product_id
      t.boolean :reserved, default: false

      t.timestamps
    end
  end
end
