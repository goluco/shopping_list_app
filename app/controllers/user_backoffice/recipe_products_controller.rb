class UserBackoffice::RecipeProductsController < UserBackofficeController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_product = RecipeProduct.new
    @products = Product.where(user: current_user)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    recipe_product_params = params.require(:recipe_product).permit(:product_id, :quantity)
    @recipe.recipe_products.create(recipe_product_params)
    redirect_to user_backoffice_recipe_path(@recipe.id), notice: 'Produto adicionado com sucesso'
  end
end
