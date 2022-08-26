class UserBackoffice::RecipeProductsController < UserBackofficeController
  before_action :set_recipe, only: %i[new create destroy edit update]
  before_action :set_recipe_product, only: %i[destroy edit update]

  def new
    @recipe_product = RecipeProduct.new
    @products = Product.where(user: current_user)
  end

  def create
    recipe_product_params = params.require(:recipe_product).permit(:product_id, :quantity)
    @recipe.recipe_products.create(recipe_product_params)
    redirect_to user_backoffice_recipe_path(@recipe.id), notice: 'Produto adicionado com sucesso'
  end

  def destroy
    @recipe.recipe_products.destroy(@recipe_product)
    @recipe_product.destroy
    redirect_to user_backoffice_recipe_path(@recipe.id), notice: 'Produto removido com sucesso'
  end

  def edit; end

  def update
    recipe_product_params = params.require(:recipe_product).permit(:quantity)
    @recipe_product.update(recipe_product_params)
    redirect_to user_backoffice_recipe_path(@recipe.id), notice: 'Quantidade alterada com sucesso'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_product
    @recipe_product = RecipeProduct.find(params[:id])
  end
end
