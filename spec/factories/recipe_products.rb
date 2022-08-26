FactoryBot.define do
  factory :recipe_product do
    product { create(:product) }
    quantity { 1 }
  end
end
