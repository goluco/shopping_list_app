FactoryBot.define do
  factory :list do
    name { "Lista Genérica" }
    people { 3 }
    user { create(:user) }
  end
end
