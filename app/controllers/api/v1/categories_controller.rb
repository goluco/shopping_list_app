class Api::V1::CategoriesController < Api::V1::ApiController
  rescue_from ActiveRecord::RecordInvalid, with: :render_errors

  def create
    @user = current_user
    @category = Category.new(category_params)
    @category.save!
    render status: :created, json: @category
  end

  private

  def category_params
    params.require(:category).permit(:name).merge(user_id: @user.id)
  end

  def render_errors
    render status: :precondition_failed, json: { errors: @category.errors.full_messages }
  end
end
