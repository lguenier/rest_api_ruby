class Reservation < ApplicationRecord
  has_many :products_reservations
  has_many :products, through: :products_reservations

  validates :status, inclusion: %w(RESERVED BACKORDER PENDING)
end
