class ProductsReservation < ApplicationRecord
  belongs_to :product
  belongs_to :reservation, touch: true

  validates_presence_of :quantity

  def now_reserved?
    self.product.with_lock do
      if self.product.available >= self.quantity
        self.update(reserved: true)
        return true
      else
        return false
      end
    end
  end
end
