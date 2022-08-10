FactoryBot.define do
  factory :user do
    name { 'Maria Augusta Ribeiro' }
    email { 'mauri@email.com' }
    password { 'senha1234' }
    password_confirmation { 'senha1234' }
  end
end
