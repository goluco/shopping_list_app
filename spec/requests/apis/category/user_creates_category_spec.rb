require 'rails_helper'

describe 'Usuário cria nova categoria' do
  it 'com sucesso' do
    user = create(:user)
    category_params = { category: { name: 'Legumes e Verduras' } }

    login_as(user)
    post '/api/v1/categories', params: category_params

    expect(response).to have_http_status(:created)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['name']).to eq('Legumes e Verduras')
  end

  it 'com informações incorretas' do
    user = create(:user)
    category_params = { category: { name: '' } }

    login_as(user)
    post '/api/v1/categories', params: category_params

    expect(response).to have_http_status(:precondition_failed)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['errors']).to include 'Nome da categoria não pode ficar em branco'
  end

  it 'sem estar logado' do
    category_params = { category: { name: 'Produtos de Limpeza' } }

    post '/api/v1/categories', params: category_params

    expect(response).to have_http_status(:unauthorized)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to include 'Usuário não autenticado'
  end
end
