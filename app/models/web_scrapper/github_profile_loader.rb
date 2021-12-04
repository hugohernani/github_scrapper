module WebScrapper
  class GithubProfileLoader
    def initialize(user_id:, web_scrapper: WebScrapper::GithubProfile.new)
      @user_id      = user_id
      @web_scrapper = web_scrapper
    end

    def load_onto_user(url:)
      profile_data = web_scrapper.load_data(url: url)
      User.persist_github_profile(user_id: user_id, profile: profile_data)
    end

    private

    attr_reader :user_id, :web_scrapper
  end
end
