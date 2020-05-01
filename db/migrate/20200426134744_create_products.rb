class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
