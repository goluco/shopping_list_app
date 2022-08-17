FactoryBot.define do
  factory :recipe do
    name { "Mousse de Limão" }
    instructions { 
      "Misture o suco do limão, o leite condensado e o creme de leite e bata no
      liquidificador até ficar uniforme. Em seguida leve ao freezer ou ao congelador
      por cerca de 40 minutos. Sirva gelado."
    }
    people { 2 }
    user { create(:user) }
  end
end
