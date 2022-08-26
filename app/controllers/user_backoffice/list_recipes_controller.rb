class UserBackoffice::ListRecipesController < UserBackofficeController
  before_action :set_list
  before_action :set_list_recipe, only: %i[destroy]

  def new
    @list = List.find(params[:list_id])
    @list_recipe = ListRecipe.new
    @recipes = Recipe.where(user: current_user)
  end

  def create
    @list = List.find(params[:list_id])
    list_recipe_params = params.require(:list_recipe).permit(:recipe_id)
    @list.list_recipes.create(list_recipe_params)
    redirect_to user_backoffice_list_path(@list.id), notice: 'Receita adicionada com sucesso'
  end

  def destroy
    @list.list_recipes.destroy(@list_recipe)
    @list_recipe.destroy
    redirect_to user_backoffice_list_path(@list.id), notice: 'Receita removida com sucesso'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_list_recipe
    @list_recipe = ListRecipe.find(params[:id])
  end
end
