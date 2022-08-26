require 'rails_helper'

describe 'Usuário edita informações da lista' do
  it 'com sucesso' do
    user = create(:user)
    list = create(:list, user: user)

    login_as(user)
    visit root_path
    click_on 'Listas'
    click_on I18n.l(list.created_at)
    click_on 'Editar'
    fill_in 'Nome (não obrigatório)', with: 'Lista de Marca'
    fill_in 'Número de pessoas', with: 5
    click_on 'Salvar'

    expect(page).to have_current_path(user_backoffice_lists_path)
    expect(page).to have_content('Lista atualizada com sucesso')
    list.reload
    expect(list.name).to eq('Lista de Marca')
    expect(page).to have_content("#{I18n.l(list.created_at)} | 5 pessoas")
    expect(page).not_to have_content("#{I18n.l(list.created_at)} | 3 pessoas")
  end
end
