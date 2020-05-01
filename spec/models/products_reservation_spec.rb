require 'rails_helper'

RSpec.describe ProductsReservation, type: :model do
  # Association test
  it { should belong_to(:product)}
  it { should belong_to(:reservation) }

  # Validation
  it { should validate_presence_of(:quantity)}
end
