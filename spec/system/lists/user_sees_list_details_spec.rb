require 'rails_helper'

describe 'Usuário visualiza detalhes de uma lista' do
  it 'com sucesso' do
    user = create(:user)
    list = create(:list, user: user)
    recipe = create(:recipe, user: user)
    recipe2 = create(:recipe, name: 'Salada', instructions: '', user: user)
    list.list_recipes.create(recipe: recipe)
    list.list_recipes.create(recipe: recipe2)

    login_as(user)
    visit root_path
    click_on 'Listas'
    click_on I18n.l(list.created_at)

    expect(page).to have_current_path(user_backoffice_list_path(list.id))
    expect(page).to have_content('Lista Genérica')
    expect(page).to have_content('3 pessoas')
    expect(page).to have_link('Mousse de Limão')
    expect(page).to have_link('Salada')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Adicionar receita')
  end

  it 'e não há nenhuma receita cadastrada' do
    user = create(:user)
    list = create(:list, user: user)

    login_as(user)
    visit user_backoffice_list_path(list.id)

    expect(page).to have_content('Lista Genérica')
    expect(page).to have_content('3 pessoas')
    expect(page).to have_content('Ainda não há receitas cadastradas para esta lista. Para adicionar, clique no botão abaixo.')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Adicionar receita')
  end
end
