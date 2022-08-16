require 'rails_helper'

describe 'Usuário visita página de produtos' do
  it 'e vê os produtos cadastrados' do
    user = create(:user)
    category = create(:category, user: user)
    other_category = create(:category, name: 'Carnes e Congelados', user: user)
    create(:product, category: category)
    create(:product, name: 'Alcatra', category: other_category)

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
end
