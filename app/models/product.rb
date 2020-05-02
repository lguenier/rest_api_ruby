class Product < ApplicationRecord
  has_many :inventories, dependent: :destroy
  has_many :products_reservations

  validates_presence_of :product
  validates_uniqueness_of :product
  validates :product, inclusion: %w(PIPR-JACKET-SIZM PIPR-JACKET-SIZL PIPR-JACKET-SIXL PIPR-SVLMUG-GREN PIPR-SVLMUG-YLOW PIPR-MOSPAD-0000 PIPR-SMFRDG-0000)

  after_save :check_backorder

  default_scope { order(:id) }

  def reserved
    ProductsReservation.where(reserved: true).where(product_id: self.id).pluck(:quantity).sum
  end

  def available
    self.quantity - self.reserved
  end

  def check_backorder
    self.products_reservations.where(reserved: false).each do |pr|
      break unless pr.now_reserved?
    end
  end
end
