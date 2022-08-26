class UserBackoffice::ListsController < UserBackofficeController
  before_action :set_list, only: %i[show edit update]

  def index
    @lists = List.where(user: current_user)
  end

  def new
    @list = List.new
  end

  def create
    @user = current_user
    @list = List.new(create_list_params)
    if @list.save
      redirect_to user_backoffice_lists_path, notice: 'Lista criada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível criar a lista. Verifique os erros abaixo'
      render 'new'
    end
  end

  def edit; end

  def update
    if @list.update(update_list_params)
      redirect_to user_backoffice_lists_path, notice: 'Lista atualizada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar. Verifique os erros abaixo'
    end
  end

  def show; end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def create_list_params
    params.require(:list).permit(:name, :people).merge(user_id: @user.id)
  end

  def update_list_params
    params.require(:list).permit(:name, :people)
  end
end
