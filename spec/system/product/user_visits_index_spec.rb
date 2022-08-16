require 'rails_helper'

describe 'Usuário visita página de produtos' do
  it 'e vê os produtos cadastrados' do
    user = create(:user)
    category = create(:category, user: user)
    other_category = create(:category, name: 'Carnes e Congelados', user: user)
    create(:product, category: category, user: user)
    create(:product, name: 'Alcatra', category: other_category, user: user)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_current_path(user_backoffice_products_path)
    expect(page).to have_css 'h4', text: 'Legumes e Verduras'
    within("ul.#{category.name.gsub(' ', '')}") do
      expect(page).to have_css 'li', text: 'Tomate'
    end
    expect(page).to have_css 'h4', text: 'Carnes e Congelados'
    within("ul.#{other_category.name.gsub(' ', '')}") do
      expect(page).to have_css 'li', text: 'Alcatra'
    end
  end

  it 'e não há produtos cadastrados' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_current_path(user_backoffice_products_path)
    expect(page).to have_content('Não existem produtos cadastrados')
  end

  it 'e vê apenas os produtos cadastrados por ele' do
    user = create(:user)
    other_user = create(:user, name: 'Teia', email: 'teia@email.com')
    category = create(:category, user: user)
    category2 = create(:category, name: 'Congelados', user: user)
    other_category = create(:category, name: 'Limpeza', user: other_user)
    other_category2 = create(:category, name: 'Matinais', user: other_user)
    create(:product, category: category, user: user)
    create(:product, name: 'Pão de queijo', category: category2, user: user)
    create(:product, name: 'Detergente', category: other_category, user: other_user)
    create(:product, name: 'Café', category: other_category2, user: other_user)

    login_as(user)
    visit user_backoffice_products_path

    expect(page).to have_css 'h4', text: 'Legumes e Verduras'
    expect(page).to have_css 'h4', text: 'Congelados'
    expect(page).not_to have_css 'h4', text: 'Limpeza'
    expect(page).not_to have_css 'h4', text: 'Matinais'
    expect(page).not_to have_content('Detergente')
    expect(page).not_to have_content('Café')
    within("ul.#{category.name.gsub(' ', '')}") do
      expect(page).to have_css 'li', text: 'Tomate'
    end
    within("ul.#{category2.name.gsub(' ', '')}") do
      expect(page).to have_css 'li', text: 'Pão de queijo'
    end
  end
end
