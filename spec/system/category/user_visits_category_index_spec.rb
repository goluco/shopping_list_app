require 'rails_helper'

describe 'Usuário visita página de categorias' do
  it 'e vê as categorias listadas' do
    user = create(:user)
    category = create(:category, user: user)
    category2 = create(:category, name: 'Produtos de Limpeza', user: user)
    category3 = create(:category, name: 'Carne e Congelados', user: user)

    login_as(user)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content(category.name)
    expect(page).to have_content(category2.name)
    expect(page).to have_content(category3.name)
  end

  it 'e não há categoria criada' do
    user = create(:user)

    login_as(user)
    visit user_backoffice_categories_path

    expect(page).to have_content('Ainda não há categorias criadas')
  end

  it 'e não vê as categorias criadas por outros usuários' do
    user = create(:user)
    other_user = create(:user, name: 'Tetiiz', email: 'tetiiz@email.com')
    category_user = create(:category, user: user)
    category_user2 = create(:category, name: 'Carnes e Congelados', user: user)
    category_other_user = create(:category, name: 'Produzos de Limpeza', user: other_user)
    category_other_user2 = create(:category, name: 'Café/Massas', user: other_user)

    login_as(user)
    visit user_backoffice_categories_path

    expect(page).to have_content(category_user.name)
    expect(page).to have_content(category_user2.name)
    expect(page).not_to have_content(category_other_user.name)
    expect(page).not_to have_content(category_other_user2.name)
  end
end
