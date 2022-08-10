# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário visita homepage' do
  it 'e visualiza título' do
    visit root_path

    expect(page).to have_content('APP de lista de compras')
    expect(page).to have_link('Fazer login')
    expect(page).to have_link('Fazer cadastro')
  end
end
