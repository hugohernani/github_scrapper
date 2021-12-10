module Github
  class UserScrappingFacade
    def initialize(link_shorten:, web_scrapper:)
      @link_shorten = link_shorten
      @web_scrapper = web_scrapper
    end

    def perform(target_url:, user_id:)
      persist_short_url_on_user(target_url, user_id)
      webscrap_github_profile(target_url, user_id)
    end

    private

    attr_reader :link_shorten, :web_scrapper

    def persist_short_url_on_user(long_url, user_id)
      short_url = link_shorten.generate(url: long_url)
      User.add_short_url(user_id: user_id, short_url: short_url)
    end

    def webscrap_github_profile(long_url, user_id)
      WebScrapper::GithubProfileLoader
        .new(user_id: user_id, web_scrapper: web_scrapper)
        .load_onto_user(url: long_url)
    end
  end
end
