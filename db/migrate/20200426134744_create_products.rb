class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :slug
      t.string :name
      t.string :product

      t.timestamps
    end
  end
end
