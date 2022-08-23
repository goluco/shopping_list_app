require 'rails_helper'

describe 'Usuário adiciona receitas à lista de compras' do
  it 'com sucesso' do
    user = create(:user)
    list = create(:list, user: user, people: 4)
    category = create(:category, user: user)
    category2 = create(:category, name: 'Café/Massas', user: user)
    category3 = create(:category, name: 'Temperos', user: user)
    product = create(:product, category: category, user: user)
    product2 = create(:product, name: 'Limão', category: category, user: user)
    product3 = create(:product, name: 'Cebola', category: category, user: user)
    product4 = create(:product, name: 'Pepino', category: category, user: user)
    product5 = create(:product, name: 'Maço de Cheiro Verde', category: category, user: user)
    product6 = create(:product, name: 'Creme de Leite de caixinha', category: category2, user: user)
    product7 = create(:product, name: 'Leite condensado de caixinha', category: category2, user: user)
    product8 = create(:product, name: 'Azeite', category: category3, user: user)
    recipe = create(:recipe, user: user)
    recipe2 = create(:recipe, name: 'Salada', instructions: '', user: user)
    recipe.recipe_products.create(product_id: product2.id, quantity: 2)
    recipe.recipe_products.create(product_id: product6.id, quantity: 1)
    recipe.recipe_products.create(product_id: product7.id, quantity: 1)
    recipe2.recipe_products.create(product_id: product.id, quantity: 1)
    recipe2.recipe_products.create(product_id: product2.id, quantity: 1)
    recipe2.recipe_products.create(product_id: product3.id, quantity: 1)
    recipe2.recipe_products.create(product_id: product4.id, quantity: 1)
    recipe2.recipe_products.create(product_id: product5.id, quantity: 1)
    recipe2.recipe_products.create(product_id: product8.id, quantity: 1)

    login_as(user)
    visit root_path
    click_on 'Listas'
    click_on I18n.l(list.created_at)
    click_on 'Adicionar receita'
    select recipe.name, from: 'Receitas'
    click_on 'Salvar'
    click_on 'Adicionar receita'
    select recipe2.name, from: 'Receitas'
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_list_path(list.id))
    expect(page).to have_css 'h4', text: category.name
    expect(page).to have_css 'h4', text: category2.name
    expect(page).to have_css 'h4', text: category3.name
    within("ul.#{category.name.gsub(' ', '')}") do
      expect(page).to have_content("1 x #{product.name}")
      expect(page).to have_content("3 x #{product2.name}")
      expect(page).to have_content("1 x #{product3.name}")
      expect(page).to have_content("1 x #{product4.name}")
      expect(page).to have_content("1 x #{product5.name}")
    end
    within("ul.#{category2.name.gsub(' ', '')}") do
      expect(page).to have_content("1 x #{product6.name}")
      expect(page).to have_content("1 x #{product7.name}")
    end
    within("ul.#{category3.name.gsub(' ', '')}") do
      expect(page).to have_content("1 x #{product8.name}")
    end
  end
end
