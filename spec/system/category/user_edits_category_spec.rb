require 'rails_helper'

describe 'Usuário edita categoria existente' do
  it 'com sucesso' do
    user = create(:user)
    create(:category)

    login_as(user)
    visit user_backoffice_categories_path
    click_on 'Editar'
    fill_in 'Nome da categoria', with: 'Hortifruti'
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_categories_path)
    expect(page).to have_content('Hortifruti')
    expect(page).not_to have_content('Legumes e Verduras')
  end

  it 'com dados incompletos' do
    user = create(:user)
    create(:category)

    login_as(user)
    visit user_backoffice_categories_path
    click_on 'Editar'
    fill_in 'Nome da categoria', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível editar a categoria. Verifique os erros abaixo')
    expect(page).to have_content('Nome da categoria não pode ficar em branco')
  end
end
