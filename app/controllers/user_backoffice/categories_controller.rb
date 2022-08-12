class UserBackoffice::CategoriesController < UserBackofficeController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to user_backoffice_categories_path, notice: 'Categoria adicionada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível criar a categoria. Verifique os erros abaixo'
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to user_backoffice_categories_path, notice: 'Categoria atualizada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível editar a categoria. Verifique os erros abaixo'
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to user_backoffice_categories_path, notice: 'Categoria deletada com sucesso.'
  end

  private

  def category_params
    category_params = params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end