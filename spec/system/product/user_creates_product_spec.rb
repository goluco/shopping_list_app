require 'rails_helper'

describe 'Usuário cria produto' do
  it 'com sucesso' do
    user = create(:user)
    category = create(:category)

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
end
