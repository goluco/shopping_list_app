require 'rails_helper'

describe 'Usuário adiciona ingredientes a uma receita' do
  it 'com sucesso' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    category = create(:category,user: user)
    other_category = create(:category, name: 'Café/Massas', user: user)
    product = create(:product, name: 'Limão', user: user, category: category)
    create(:product, name: 'Leite condensado', user: user, category: other_category)

    login_as(user)
    visit user_backoffice_recipe_path(recipe.id)
    click_on 'Adicionar produto à receita'
    select product.name, from: 'Produto'
    fill_in 'Quantidade', with: '2'
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_recipe_path(recipe.id))
    expect(page).to have_content('Produto adicionado com sucesso')
    expect(page).to have_content('2 x Limão')
  end
end
