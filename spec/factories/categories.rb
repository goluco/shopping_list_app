FactoryBot.define do
  factory :category do
    name { "Legumes e Verduras" }
    user { create(:user) }
  end
end
