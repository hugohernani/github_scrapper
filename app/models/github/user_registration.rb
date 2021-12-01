module Github
  class UserRegistration
    def initialize(github_user_form)
      @github_user_form = github_user_form
    end

    def create
      User.create(
        name: github_user_form.name,
        url: github_user_form.url
      )
    end

    private

    attr_reader :github_user_form
  end
end
