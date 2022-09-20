# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordInvalid, with: :render_errors

  def create
    @user = User.new(user_params)
    @user.save!
    render status: :created, json: { user: @user }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def render_errors
    render status: :precondition_failed, json: { errors: @user.errors.full_messages }
  end
end
