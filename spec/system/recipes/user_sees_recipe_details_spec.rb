require 'rails_helper'

describe 'Usuário visita página individual de uma receita' do
  it 'e vê os detalhes da receita' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit user_backoffice_recipe_path(recipe.id)

    expect(page).to have_content('Nome da receita: Mousse de Limão')
    expect(page).to have_content('Instruções: Misture o suco do limão, o leite condensado e o creme de leite e bata no liquidificador até ficar uniforme. Em seguida leve ao freezer ou ao congelador por cerca de 40 minutos. Sirva gelado.')
    expect(page).to have_content('Pessoas: 2')
    expect(page).to have_link('Editar')
  end
end
