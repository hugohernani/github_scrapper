class UsersController < ApplicationController
  def index
    database_users = User.with_github_profile
    @users         = UsersContainerPresenter.new(database_users)
                                            .search(search_query: params[:q])
  end

  def new
    @user = UserPresenter.new(db_user: User.new)
    @form = UserForm.new
  end

  def create
    @form = UserForm.new(user_form_params)
    register_service = user_registration_service

    if @form.valid?
      register_service.create(listeners: ::Users::TurboBroadcasting.new)
      redirect_to user_path(register_service.user), notice: t('.success')
    else
      @user = UserPresenter.new(db_user: User.new)
      render :new
    end
  end

  def show
    @user   = UserPresenter.new(db_user: find_user)
  end

  def edit
    @user = UserPresenter.new(db_user: find_user)
    @form = UserForm.new(name: @user.name, url: @user.url)
  end

  def update
    @form = UserForm.new(user_form_params)
    user  = find_user

    if @form.valid?
      user_update_service(user, @form).update
      redirect_to user_path(user), notice: t('.success')
    else
      render :new
    end
  end

  def destroy
    User.destroy(params[:id])

    redirect_to root_path, notice: t('.success')
  end

  private

  def find_user
    User.find(params[:id])
  end

  def user_form_params
    params.require(:user_form).permit(:name, :url)
  end

  def user_registration_service
    Github::UserRegistration.new(@form, link_shorten: shortner)
  end

  def user_update_service(user, form)
    Github::UserUpdate.new(form, user: user, link_shorten: shortner)
  end

  def shortner
    ENV['USE_FAKE_BITLY'] ? Shortner::FakeBitly.new : Shortner::Bitly.new
  end
end
