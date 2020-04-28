class Reservation < ApplicationRecord
  has_many :products_reservations
  has_many :products, through: :products_reservations

  accepts_nested_attributes_for :products_reservations
  validates :status, inclusion: %w(RESERVED BACKORDER PENDING)

  def products_list
    list = self.products_reservations.group(:product_id).count
    list.map do |k, v|
      {product: Product.find(k).product, quantity: v}
    end
  end
end
