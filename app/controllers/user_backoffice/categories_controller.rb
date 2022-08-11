class UserBackoffice::CategoriesController < UserBackofficeController

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

  private

  def category_params
    category_params = params.require(:category).permit(:name)
  end
end