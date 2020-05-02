class Reservation < ApplicationRecord
  has_many :products_reservations, dependent: :destroy
  has_many :products, through: :products_reservations

  accepts_nested_attributes_for :products_reservations
  validates :status, inclusion: %w(RESERVED BACKORDER PENDING)

  default_scope { order(:id) }

  after_create :check_status
  after_touch :check_status

  def products_list
    list = self.products_reservations
    list.map do |pr|
      {product: Product.find(pr.product_id).product, quantity: pr.quantity}
    end
  end

  def check_status
    self.products_reservations.where(reserved: false).each do |pr|
      pr.now_reserved?
    end
    if self.products_reservations.where(reserved: false).count == 0
      self.update(status: "RESERVED")
    else
      self.update(status: "BACKORDER")
    end
  end
end
