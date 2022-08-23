require 'rails_helper'

describe 'Usuário visita index das listas de compras' do
  it 'e visualiza as listas' do
    user = create(:user)
    list = create(:list, user: user)

    login_as(user)
    visit root_path
    click_on 'Listas'

    expect(page).to have_current_path(user_backoffice_lists_path)
    expect(page).to have_content("#{I18n.l(list.created_at)} | 3 pessoas")
  end

  it 'e não há listas criadas' do
    user = create(:user)

    login_as(user)
    visit user_backoffice_lists_path

    expect(page).to have_content('Ainda não existem listas de compra cadastradas')
  end

  it 'e não vê as listas de outro usuário' do
    user = create(:user)
    other_user = create(:user, name: 'Tetiiz', email: 'tetiiz@email.com')
    list = create(:list, user: user)
    other_list = create(:list, user: other_user, people: 5)

    login_as(user)
    visit user_backoffice_lists_path

    expect(page).to have_content("#{I18n.l(list.created_at)} | 3 pessoas")
    expect(page).not_to have_content("#{I18n.l(other_list.created_at)} | 5 pessoas")
  end
end
