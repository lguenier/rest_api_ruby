FactoryBot.define do
  factory :reservation do
    status { %w(RESERVED BACKORDER PENDING) }
  end
end