class Product < ApplicationRecord
  has_many :inventories, dependent: :destroy
  has_many :products_reservations

  validates_presence_of :name, :product
  validates_uniqueness_of :name
  validates_uniqueness_of :product
  validates :product, inclusion: %w(PIPR-JACKET-SIZM PIPR-JACKET-SIZL PIPR-JACKET-SIXL PIPR-SVLMUG-GREN PIPR-SVLMUG-YLOW PIPR-MOSPAD-0000 PIPR-SMFRDG-0000)

  def self.list_inventory(limit, cursor)
    if limit
      if cursor
        where(id > cursor).first(limit).map {|p| {product: p.product, quantity: p.inventories.count, available: Inventory.available_items(p.id).count}}
      else
        first(limit).map {|p| {product: p.product, quantity: p.inventories.count, available: Inventory.available_items(p.id).count}}
      end
    elsif cursor
      where(id > cursor).map {|p| {product: p.product, quantity: p.inventories.count, available: Inventory.available_items(p.id).count}}
    else
      all.map {|p| {product: p.product, quantity: p.inventories.count, available: Inventory.available_items(p.id).count}}
    end
  end
end
