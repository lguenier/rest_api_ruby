require 'rails_helper'

RSpec.describe Reservation, type: :model do
  # Association
  # Should have many products reservations and products through products reservations
  it { should have_many(:products_reservations)}
  it { should have_many(:products).through(:products_reservations)}

  # Validation
  # Should have a status before saving
  it { should validate_inclusion_of(:status).in_array(%w[RESERVED BACKORDER PENDING]) }
end
