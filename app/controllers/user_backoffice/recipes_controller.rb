class UserBackoffice::RecipesController < UserBackofficeController
  before_action :set_recipe, only: %i[edit update show]

  def index
    @recipes = Recipe.where(user: current_user)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.new(create_recipe_params)
    if @recipe.save
      redirect_to user_backoffice_recipes_path, notice: 'Receita adicionada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível adicionar a receita. Verifique os erros abaixo'
      render 'new'
    end
  end

  def show
    @categories = Category.where(user: current_user)
  end

  def edit; end

  def update
    if @recipe.update(update_recipe_params)
      redirect_to user_backoffice_recipe_path(@recipe.id), notice: 'Receita atualizada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar a receita. Verifique os erros abaixo'
      render 'edit'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def update_recipe_params
    params.require(:recipe).permit(:name, :instructions, :people)
  end

  def create_recipe_params
    params.require(:recipe).permit(:name, :instructions, :people).merge(user_id: @user.id)
  end
end
