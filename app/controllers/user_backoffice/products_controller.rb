class UserBackoffice::ProductsController < UserBackofficeController
  before_action :set_product, only: %i[edit update]
  
  def index
    @products = Product.all
    @categories = Category.all
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

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to user_backoffice_products_path, notice: 'Produto atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível editar o produto. Verifique os erros abaixo'
      render 'edit'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
