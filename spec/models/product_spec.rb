require 'rails_helper'

RSpec.describe Product, type: :model do
  # Association test
  it { should have_many(:products_reservations) }

  # Validation test
  # Validates that it has a unique name and product before saving
  it { should validate_presence_of(:product) }
  it { should validate_uniqueness_of(:product) }
  it { should validate_inclusion_of(:product).in_array(%w(PIPR-JACKET-SIZM PIPR-JACKET-SIZL PIPR-JACKET-SIXL PIPR-SVLMUG-GREN PIPR-SVLMUG-YLOW PIPR-MOSPAD-0000 PIPR-SMFRDG-0000))}
end
