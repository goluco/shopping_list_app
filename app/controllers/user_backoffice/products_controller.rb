class UserBackoffice::ProductsController < UserBackofficeController
  before_action :set_product, only: %i[edit update]

  def index
    @products = Product.where(user: current_user)
    @categories = Category.where(user: current_user)
  end

  def new
    @user = current_user
    @product = Product.new
  end

  def create
    @user = current_user
    @product = Product.new(create_product_params)
    if @product.save
      redirect_to user_backoffice_products_path, notice: 'Produto adicionado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível adicionar o produto. Verifique os erros abaixo'
      render 'new'
    end
  end

  def edit; end

  def update
    if @product.update(update_product_params)
      redirect_to user_backoffice_products_path, notice: 'Produto atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível editar o produto. Verifique os erros abaixo'
      render 'edit'
    end
  end

  private

  def create_product_params
    params.require(:product).permit(:name, :category_id).merge(user_id: @user.id)
  end

  def update_product_params
    params.require(:product).permit(:name, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
