require 'rails_helper'

describe 'Usuário edita receita' do
  it 'com sucesso' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit user_backoffice_recipes_path
    click_on 'Mousse de Limão'
    click_on 'Editar'
    fill_in 'Nome da receita', with: 'Mousse de café'
    fill_in 'Instruções', with: ''
    fill_in 'Pessoas', with: 4
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_recipe_path(recipe.id))
    expect(page).to have_content('Receita atualizada com sucesso')
    expect(page).to have_content('Nome da receita: Mousse de café')
    expect(page).to have_content('Pessoas: 4')
  end

  it 'com informações incompletas' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit user_backoffice_recipe_path(recipe.id)
    click_on 'Editar'
    fill_in 'Nome da receita', with: ''
    fill_in 'Pessoas', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível atualizar a receita. Verifique os erros abaixo')
    expect(page).to have_content('Nome da receita não pode ficar em branco')
    expect(page).to have_content('Pessoas não pode ficar em branco')
  end
end
