require 'rails_helper'

describe 'Usuário edita produto' do
  it 'com sucesso' do
    user = create(:user)
    category = create(:category, user: user)
    product = create(:product, category: category, user: user)

    login_as(user)
    visit user_backoffice_products_path
    within('li.Tomate') do
      click_on 'Editar'
    end
    fill_in 'Nome do produto', with: 'Caqui'
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_products_path)
    expect(page).to have_content('Produto atualizado com sucesso')
    expect(page).to have_css 'h4', text: product.category.name
    within("ul.#{product.category.name.gsub(' ', '')}") do
      expect(page).to have_css 'li', text: 'Caqui'
      expect(page).not_to have_css 'li', text: 'Tomate'
    end
  end

  it 'com informações incompletas' do
    user = create(:user)
    category = create(:category, user: user)
    product = create(:product, category: category, user: user)

    login_as(user)
    visit edit_user_backoffice_product_path(product.id)
    fill_in 'Nome do produto', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível editar o produto. Verifique os erros abaixo')
    expect(page).to have_content('Nome do produto não pode ficar em branco')
  end
end
