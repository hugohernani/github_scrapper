module Github
  class UserRegistration
    def initialize(github_user_form, link_shorten:)
      @github_user_form = github_user_form
      @link_shorten     = link_shorten
    end

    def create
      User.create(
        name: github_user_form.name,
        url: github_user_form.url
      )
      link_shorten.generate(url: github_user_form.url)
    end

    private

    attr_reader :github_user_form, :link_shorten
  end
end
