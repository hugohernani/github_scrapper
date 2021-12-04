class UserPresenter < BasePresenter
  attr_accessor :page_navigation

  delegate :name, :url, :short_url, to: :@user
  delegate :username, :followers, :following, :stars, :contributions, :image_url,
           to: :@github_profile, prefix: :github

  def initialize(db_user:)
    @user            = db_user
    @github_profile  = @user.github_profile
    @page_navigation = UserPresenters::PageNavigation.new(db_user: db_user)
  end

  def last_github_scrapping_update
    h.t('user_registration.show.last_seen_at', last_seen_at: h.l(user.github_profile.updated_at))
  end

  private

  attr_reader :user, :github_profile
end
