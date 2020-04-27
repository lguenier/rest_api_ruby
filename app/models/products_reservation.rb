class ProductsReservation < ApplicationRecord
  belongs_to :product
  belongs_to :reservation
  belongs_to :inventory, optional: true
end
