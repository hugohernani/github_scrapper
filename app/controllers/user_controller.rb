class UserController < ApplicationController
  def show
    db_user = User.find(params[:id])
    @user   = UserPresenter.new(db_user: db_user)
  end
end
