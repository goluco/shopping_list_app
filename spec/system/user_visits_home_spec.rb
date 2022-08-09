# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário visita homepage' do
  it 'e visualiza título' do
    visit root_path

    within 'header' do
      expect(page).to have_content('APP de lista de compras')
    end
  end
end
