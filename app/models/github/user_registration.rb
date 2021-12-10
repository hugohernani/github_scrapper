module Github
  class UserRegistration
    attr_reader :user

    def initialize(github_user_form,
                   link_shorten: Shortner::Bitly.new,
                   web_scrapper: WebScrapper::GithubProfile.new)
      @github_user_form = github_user_form
      @link_shorten     = link_shorten
      @web_scrapper     = web_scrapper
    end

    def create
      @user = persist_user
      UserScrappingFacade.new(
        link_shorten: link_shorten,
        web_scrapper: web_scrapper
      ).perform(target_url: github_user_form.url, user_id: @user.id)
    end

    private

    attr_reader :github_user_form, :link_shorten, :web_scrapper

    def persist_user
      User.create(
        name: github_user_form.name,
        url: github_user_form.url
      )
    end
  end
end
