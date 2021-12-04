module UserPresenters
  class PageNavigation < BasePresenter
    def initialize(db_user:)
      @user = db_user
    end

    def refresh_profile_page_url
      github_scrapper_user_path(user)
    end

    def update_page_url
      user_path(user)
    end

    private

    attr_reader :user
  end
end
