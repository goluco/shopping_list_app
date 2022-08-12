require 'rails_helper'

describe 'Usuário visita página de categorias' do
  it 'e vê as categorias listadas' do
    user = create(:user)
    category = create(:category)
    category_2 = create(:category, name: 'Produtos de Limpeza')
    category_3 = create(:category, name: 'Carne e Congelados')

    login_as(user)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content(category.name)
    expect(page).to have_content(category.name)
    expect(page).to have_content(category.name)
  end

  it 'e não há categoria criada' do
    user = create(:user)

    login_as(user)
    visit user_backoffice_categories_path

    expect(page).to have_content('Ainda não há categorias criadas')
  end
end