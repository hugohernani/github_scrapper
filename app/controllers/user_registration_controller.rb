class UserRegistrationController < ApplicationController
  def new
    @form = GithubUserRegistrationForm.new
  end

  def create
    @form = GithubUserRegistrationForm.new(user_registration_params)

    if @form.valid?
      register_service.create
      redirect_to user_path(register_service.user), notice: t('.create') # TODO: FIX-ME
    else
      render :new
    end
  end

  private

  def user_registration_params
    params.require(:github_user_registration_form)
          .permit(:name, :url)
  end

  def register_service
    @register_service ||= Github::UserRegistration.new(@form)
  end
end
