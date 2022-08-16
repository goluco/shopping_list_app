class UserBackoffice::CategoriesController < UserBackofficeController
  before_action :set_category, only: %i[edit update]

  def index
    @categories = Category.where(user: current_user)
  end

  def new
    @category = Category.new
    @user = current_user
  end

  def create
    @user = current_user
    @category = Category.new(create_category_params)
    if @category.save
      redirect_to user_backoffice_categories_path, notice: 'Categoria adicionada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível criar a categoria. Verifique os erros abaixo'
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(update_category_params)
      redirect_to user_backoffice_categories_path, notice: 'Categoria atualizada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível editar a categoria. Verifique os erros abaixo'
      render 'edit'
    end
  end

  private

  def update_category_params
    params.require(:category).permit(:name)
  end

  def create_category_params
    params.require(:category).permit(:name).merge(user_id: @user.id)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end