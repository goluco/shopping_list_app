require 'rails_helper'

describe 'Usuário cria nova lista' do
  it 'com sucesso' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Criar nova lista de compras'
    fill_in 'Número de pessoas', with: 4
    click_on 'Salvar'

    expect(page).to have_current_path user_backoffice_lists_path
    expect(page).to have_content("#{I18n.l(List.last.created_at)} | 4 pessoas")
  end
end
