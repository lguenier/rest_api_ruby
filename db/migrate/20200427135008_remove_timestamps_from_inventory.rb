class RemoveTimestampsFromInventory < ActiveRecord::Migration[6.0]
  def change

    remove_column :inventories, :created_at, :string

    remove_column :inventories, :updated_at, :string
  end
end
