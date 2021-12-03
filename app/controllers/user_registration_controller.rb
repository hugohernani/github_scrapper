class UserRegistrationController < ApplicationController
  def new
    @form = GithubUserRegistrationForm.new
  end

  def create
    @form = GithubUserRegistrationForm.new(user_registration_params)

    if @form.valid?
      Github::UserRegistration.new(@form).create
      redirect_to new_user_registration_path, notice: t('.create') # TODO: FIX-ME
    else
      render :new
    end
  end

  private

  def user_registration_params
    params.require(:github_user_registration_form)
          .permit(:name, :url)
  end
end
