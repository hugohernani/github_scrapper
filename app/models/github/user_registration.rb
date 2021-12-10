module Github
  class UserRegistration
    include Github::UserScrappingEnqueuer
    include ::SubscriptionListener

    attr_reader :user

    def initialize(user_form,
                   link_shorten: Shortner::Bitly.new,
                   web_scrapper: WebScrapper::GithubProfile.new)
      @user_form    = user_form
      @link_shorten = link_shorten
      @web_scrapper = web_scrapper
    end

    def create(listeners: [])
      @user = persist_user
      subscribe(listeners: listeners, on_publisher: User)
      enqueue_default_scrapping(link_shorten: link_shorten, web_scrapper: web_scrapper,
                                target_url: user_form.url, user_id: @user.id)
    end

    private

    attr_reader :user_form, :link_shorten, :web_scrapper

    def persist_user
      User.persist(user_form)
    end

    def subscribe_listeners(user)
      listeners.each do |listener|
        user.subscribe(listener)
      end
    end
  end
end
