FactoryBot.define do
  factory :product do
    name { "Tomate" }
    category { create(:category) }
  end
end
