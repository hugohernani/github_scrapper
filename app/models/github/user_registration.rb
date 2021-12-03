module Github
  class UserRegistration
    def initialize(github_user_form, link_shorten: Shortner::Bitly.new, web_scrapper: WebScrapper::GithubProfile.new)
      @github_user_form = github_user_form
      @link_shorten     = link_shorten
      @web_scrapper     = web_scrapper
    end

    def create
      user         = persist_user
      short_url    = shorten_url
      profile_data = webscrap_github_profile_data
      persist_short_url_on_user(user.id, short_url)
      persist_github_profile(user.id, profile_data)
    end

    private

    attr_reader :github_user_form, :link_shorten, :web_scrapper

    def persist_user
      User.create(
        name: github_user_form.name,
        url: github_user_form.url
      )
    end

    def shorten_url
      link_shorten.generate(url: github_user_form.url)
    end

    def webscrap_github_profile_data
      web_scrapper.load_data(url: github_user_form.url)
    end

    def persist_short_url_on_user(user_id, short_url)
      User.add_short_url(user_id: user_id, short_url: short_url)
    end

    def persist_github_profile(user_id, profile)
      GithubProfile.create(
        user_id: user_id,
        username: profile.username,
        followers: profile.followers,
        following: profile.following,
        stars: profile.stars,
        contributions: profile.contributions,
        image_url: profile.image_url
      )
    end
  end
end
