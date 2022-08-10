require 'rails_helper'

describe 'Usuário faz um cadastro' do
  it 'com sucesso' do
    visit root_path
    click_on 'Fazer cadastro'
    fill_in 'Nome completo', with: 'João Carlos Rogério da Silva'
    fill_in 'E-mail', with: 'jcrogerio@email.com'
    fill_in 'Senha', with: 'senha123'
    fill_in 'Confirme a senha', with: 'senha123'
    click_on 'Registrar'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
  end

  it 'com dados incompletos' do
    visit root_path
    click_on 'Fazer cadastro'
    fill_in 'Nome completo', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: 'senha123'
    fill_in 'Confirme a senha', with: 'senha123'
    click_on 'Registrar'

    expect(page).to have_content 'Nome completo não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end