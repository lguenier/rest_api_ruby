class Inventory < ApplicationRecord
  belongs_to :product

  def self.available_items(product_id)
    self.where(product_id: product_id).pluck(:id) - ProductsReservation.where(product_id: product_id).pluck(:inventory_id)
  end
end
