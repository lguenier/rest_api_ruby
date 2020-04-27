require 'rails_helper'

RSpec.describe ProductsReservation, type: :model do
  # Association
  # Should belong to product and reservation
  # Should optionally belong to inventory
  it { should belong_to(:product)}
  it { should belong_to(:reservation)}
  it { should belong_to(:inventory).optional(true)}
end
