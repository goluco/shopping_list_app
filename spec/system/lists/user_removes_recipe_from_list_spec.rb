require 'rails_helper'

describe 'Usuário remove receita de uma lista de compras' do
  it 'com sucesso' do
    user = create(:user)
    list = create(:list, user: user)
    recipe = create(:recipe, user: user)
    list.list_recipes.create(recipe: recipe)

    login_as(user)
    visit user_backoffice_list_path(list.id)
    click_on 'Remover da lista'

    expect(page).to have_content('Ainda não há receitas cadastradas para esta lista. Para adicionar, clique no botão abaixo.')
    expect(page).to have_link('Adicionar receita')
    expect(page).to have_link('Editar')
  end
end
