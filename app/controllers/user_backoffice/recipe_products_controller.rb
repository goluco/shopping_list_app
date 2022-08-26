class UserBackoffice::RecipeProductsController < UserBackofficeController
  before_action :set_recipe, only: %i[new create destroy]

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

  def destroy
    @recipe_product = RecipeProduct.find(params[:id])
    @recipe.recipe_products.destroy(@recipe_product)
    @recipe_product.destroy
    redirect_to user_backoffice_recipe_path(@recipe.id), notice: 'Produto removido com sucesso'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
