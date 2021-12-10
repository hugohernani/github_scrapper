module Github
  class UserRegistration
    include Github::UserScrappingEnqueuer

    attr_reader :user

    def initialize(user_form,
                   link_shorten: Shortner::Bitly.new,
                   web_scrapper: WebScrapper::GithubProfile.new)
      @user_form = user_form
      @link_shorten     = link_shorten
      @web_scrapper     = web_scrapper
    end

    def create
      @user = persist_user
      enqueue_default_scrapping(link_shorten: link_shorten, web_scrapper: web_scrapper,
                                target_url: user_form.url, user_id: @user.id)
    end

    private

    attr_reader :user_form, :link_shorten, :web_scrapper

    def persist_user
      User.create(
        name: user_form.name,
        url: user_form.url
      )
    end
  end
end
