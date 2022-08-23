require 'rails_helper'

describe 'Usuário cria nova lista' do
  it 'com sucesso' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Criar nova lista de compras'
    fill_in 'Nome (não obrigatório)', with: 'Lista teste'
    fill_in 'Número de pessoas', with: 4
    click_on 'Salvar'

    expect(page).to have_current_path user_backoffice_lists_path
    expect(page).to have_content("#{I18n.l(List.last.created_at)} | 4 pessoas")
  end

  it 'com informações incompletas' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Criar nova lista de compras'
    fill_in 'Nome (não obrigatório)', with: 'Lista teste'
    fill_in 'Número de pessoas', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível criar a lista. Verifique os erros abaixo')
    expect(page).to have_content('Número de pessoas não pode ficar em branco')
  end
end
