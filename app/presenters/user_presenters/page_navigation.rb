module UserPresenters
  class PageNavigation < BasePresenter
    def initialize(db_user:)
      @user = db_user
    end

    def refresh_profile_page_link
      github_scrapper_user_path(user)
    end

    def edit_user_link
      edit_user_path(user)
    end

    def user_link
      user_path(user)
    end

    private

    attr_reader :user
  end
end
