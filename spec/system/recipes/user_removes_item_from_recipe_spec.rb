require 'rails_helper'

describe 'Usuário retira item de receita' do
  it 'com sucesso' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    category = create(:category, user: user)
    product = create(:product, name: 'Limão', user: user, category: category)
    create(:recipe_product, recipe: recipe, product: product, quantity: 3)

    login_as(user)
    visit user_backoffice_recipe_path(recipe.id)
    click_on 'Retirar produto'

    expect(page).to have_current_path(user_backoffice_recipe_path(recipe.id))
    expect(page).to have_content('Produto removido com sucesso')
    expect(page).not_to have_content('3 x Limão')
  end
end
