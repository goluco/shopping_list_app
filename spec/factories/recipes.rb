FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    instructions { "MyString" }
    people { 1 }
    user { nil }
  end
end
