# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  rescue_from Errno::ECONNREFUSED, with: :authenticate_user

  private

  def authenticate_user
    render status: :unauthorized, json: { error: 'Usuário não autenticado' }
  end
end
