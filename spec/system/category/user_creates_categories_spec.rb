require 'rails_helper'

describe 'Usuário cadastra nova categoria' do
  it 'com sucesso' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Categorias'
    click_on 'Adicionar categoria'
    fill_in 'Nome da categoria', with: 'Categoria genérica'
    click_on 'Salvar'

    expect(page).to have_content('Categoria adicionada com sucesso')
    expect(page).to have_content('Categoria genérica')
  end

  it 'com nome em branco' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Categorias'
    click_on 'Adicionar categoria'
    fill_in 'Nome da categoria', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível criar a categoria. Verifique os erros abaixo')
    expect(page).to have_content('Nome da categoria não pode ficar em branco')
    expect(page).not_to have_content('Categoria adicionada com sucesso')
  end

  it 'com nome repetido' do
    user = create(:user)
    create(:category)

    login_as(user)
    visit root_path
    click_on 'Categorias'
    click_on 'Adicionar categoria'
    fill_in 'Nome da categoria', with: 'Legumes e Verduras'
    click_on 'Salvar'

    expect(page).not_to have_content('Categoria adicionada com sucesso')
    expect(page).to have_content('Não foi possível criar a categoria. Verifique os erros abaixo')
    expect(page).to have_content('Nome da categoria já está em uso')
  end
end