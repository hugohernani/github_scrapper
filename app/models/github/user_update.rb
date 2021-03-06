module Github
  class UserUpdate
    include Github::UserScrappingEnqueuer

    def initialize(user_form,
                   user:,
                   link_shorten: Shortner::Bitly.new,
                   web_scrapper: WebScrapper::GithubProfile.new)
      @user_form    = user_form
      @user         = user
      @link_shorten = link_shorten
      @web_scrapper = web_scrapper
    end

    def update
      if user_requires_scrapping_updates?
        enqueue_default_scrapping(link_shorten: link_shorten, web_scrapper: web_scrapper,
                                  target_url: user_form.url, user_id: user.id)
      end
      User.update_from_form(user, user_form)
      Users::EventNotification.notify_update(user_id: user.id)
    end

    private

    attr_reader :user_form, :user, :link_shorten, :web_scrapper

    def user_requires_scrapping_updates?
      user_form.url != user.url
    end
  end
end
