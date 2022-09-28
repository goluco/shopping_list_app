require 'rails_helper'

describe 'Usuário edita categoria' do
  it 'com sucesso' do
    user = create(:user)
    category = create(:category, user: user)
    params = { user_email: user.email, auth_token: user.authentication_token, category: { name: 'Produtos de Limpeza' } }

    patch "/api/v1/users/password/#{category.id}", params: params

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response).to include('Categoria editada com sucesso')
  end
end