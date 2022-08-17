require 'rails_helper'

describe 'Usuário cadastra nova receita' do
  it 'com sucesso' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Receitas'
    click_on 'Adicionar nova receita'
    fill_in 'Nome da receita', with: 'Mousse de Limão'
    fill_in 'Instruções', with: 'Misture o suco do limão, o leite condensado e o creme de leite e bata no
                                      liquidificador até ficar uniforme. Em seguida leve ao freezer ou ao congelador
                                      por cerca de 40 minutos. Sirva gelado.'
    fill_in 'Pessoas', with: 2
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_recipes_path)
    expect(page).to have_content('Receita adicionada com sucesso')
    expect(page).to have_content('Mousse de Limão')
  end

  it 'com informações incompletas' do
    user = create(:user)

    login_as(user)
    visit new_user_backoffice_recipe_path
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível adicionar a receita. Verifique os erros abaixo')
    expect(page).to have_content('Nome da receita não pode ficar em branco')
    expect(page).to have_content('Pessoas não pode ficar em branco')
  end
end
