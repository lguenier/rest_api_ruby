FactoryBot.define do
  factory :product do
    name { Faker::Name.first_name }
    sequence(:product) {|i| %w(PIPR-JACKET-SIZM PIPR-JACKET-SIZL PIPR-JACKET-SIXL PIPR-SVLMUG-GREN PIPR-SVLMUG-YLOW PIPR-MOSPAD-0000 PIPR-SMFRDG-0000)[i % 6] }
  end
end