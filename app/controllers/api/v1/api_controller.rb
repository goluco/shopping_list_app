class Api::V1::ApiController < ActionController::API
  respond_to :html, :json
  before_action :authentication_method
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_authentication_error

  private

  def authentication_method
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      sign_in user, store: false
    else
      raise ActiveRecord::ConnectionNotEstablished
    end
  end

  def return_authentication_error
    render status: :unauthorized, json: { error: 'Usuário não autenticado' }
  end
end
