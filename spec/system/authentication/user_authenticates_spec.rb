require 'rails_helper'

describe 'Usuário visita aplicação' do
  it 'logado' do
    user = create(:user)

    visit root_path
    click_on 'Fazer login'
    fill_in 'E-mail', with: 'mauri@email.com'
    fill_in 'Senha', with: 'senha1234'
    click_on 'Entrar'

    expect(page).to have_content(user.email)
    expect(page).to have_content("Bem vindo, #{user.name}")
    expect(page).to have_button('Sair')
    expect(page).not_to have_link('Fazer login')
    expect(page).not_to have_link('Fazer cadastro')
  end

  it 'e faz logout' do
    user = create(:user)
    login_as(user)

    visit root_path
    click_on 'Sair'

    expect(page).to have_link('Fazer login')
    expect(page).to have_link('Fazer cadastro')
    expect(page).not_to have_content(user.email)
    expect(page).not_to have_content(user.name)
    expect(page).not_to have_button('Sair')
  end
end
