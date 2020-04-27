require 'rails_helper'

RSpec.describe Inventory, type: :model do
  # Association test
  # Should belong to product
  it { should belong_to(:product)}
end
