class UserBackoffice::ProductsController < UserBackofficeController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to user_backoffice_products_path, notice: 'Produto adicionado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível adicionar o produto. Verifique os erros abaixo'
      render 'new'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :category_id)
  end
end
