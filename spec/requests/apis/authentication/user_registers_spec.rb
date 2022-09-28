require 'rails_helper'

describe 'Usuário se registra na plataforma pela primeira vez' do
  it 'com sucesso' do
    user_params = { user: { name: 'Rodrigo Hilbert', email: 'hilbert@gnt.com', password: 'strongbuilder' } }

    post '/api/v1/users', params: user_params

    expect(response).to have_http_status(:created)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['user']['name']).to eq('Rodrigo Hilbert')
    expect(json_response['user']['email']).to eq('hilbert@gnt.com')
  end

  it 'com informações incompletas' do
    user_params = { user: { name: '', email: '', password: '' } }

    post '/api/v1/users', params: user_params

    expect(response).to have_http_status(:precondition_failed)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['errors']).to include 'Nome completo não pode ficar em branco'
    expect(json_response['errors']).to include 'E-mail não pode ficar em branco'
    expect(json_response['errors']).to include 'Senha não pode ficar em branco'
  end
end
