class UserBackoffice::ListRecipesController < UserBackofficeController
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
end
