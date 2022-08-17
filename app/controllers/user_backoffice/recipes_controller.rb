class UserBackoffice::RecipesController < UserBackofficeController
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

  private

  def create_recipe_params
    params.require(:recipe).permit(:name, :instructions, :people).merge(user_id: @user.id)
  end
end
