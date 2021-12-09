module Github
  class UserUpdate
    def initialize(github_user_form,
                   user:,
                   link_shorten: Shortner::Bitly.new,
                   web_scrapper: WebScrapper::GithubProfile.new)
      @github_user_form = github_user_form
      @user             = user
      @link_shorten     = link_shorten
      @web_scrapper     = web_scrapper
    end

    def update
      if user_requires_scrapping_updates?
        short_url = shorten_url
        persist_short_url_on_user(user.id, short_url)
        webscrap_github_profile(user.id)
      end
      User.update_from_form(user, github_user_form)
    end

    private

    attr_reader :github_user_form, :user, :link_shorten, :web_scrapper

    def user_requires_scrapping_updates?
      github_user_form.url != user.url
    end

    def shorten_url
      link_shorten.generate(url: github_user_form.url)
    end

    def persist_short_url_on_user(user_id, short_url)
      User.add_short_url(user_id: user_id, short_url: short_url)
    end

    def webscrap_github_profile(user_id)
      WebScrapper::GithubProfileLoader
        .new(user_id: user_id, web_scrapper: web_scrapper)
        .load_onto_user(url: github_user_form.url)
    end
  end
end
