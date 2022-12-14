require 'rails_helper'

describe 'Usuário cria produto' do
  it 'com sucesso' do
    user = create(:user)
    category = create(:category, user: user)

    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Criar novo produto'
    fill_in 'Nome do produto', with: 'Tomate'
    select category.name, from: 'Categoria'
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_products_path)
    expect(page).to have_content('Tomate')
  end

  it 'com dados incompletos' do
    user = create(:user)
    category = create(:category, user: user)

    login_as(user)
    visit new_user_backoffice_product_path
    fill_in 'Nome do produto', with: ''
    select category.name, from: 'Categoria'
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_products_path)
    expect(page).to have_content('Não foi possível adicionar o produto. Verifique os erros abaixo')
    expect(page).to have_content('Nome do produto não pode ficar em branco')
  end
end
