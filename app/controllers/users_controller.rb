class UsersController < ApplicationController
  def index
    database_users = User.with_github_profile
    @users         = UsersContainerPresenter.new(database_users)
                                            .search(search_query: params[:q])
  end

  def new
    @form = UserForm.new
  end

  def create
    @form = UserForm.new(user_form_params)

    if @form.valid?
      register_service.create
      redirect_to user_path(register_service.user), notice: t('.create')
    else
      render :new
    end
  end

  def show
    db_user = User.find(params[:id])
    @user   = UserPresenter.new(db_user: db_user)
  end

  def edit
    @form = UserForm.new
  end

  def update
    @form = UserForm.new(user_form_params)

    if @form.valid?
      User.update_from_form(user, user_form_params)
      redirect_to user_path(user), notice: t('.create')
    else
      render :new
    end
  end

  def destroy
    User.destroy(params[:id])

    redirect_to root_path, notice: t('.create')
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_form_params
    params.require(:user_form).permit(:name, :url)
  end

  def register_service
    @register_service ||= Github::UserRegistration.new(@form)
  end
end
