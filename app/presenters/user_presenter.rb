class UserPresenter < BasePresenter
  attr_accessor :page_navigation

  delegate :id, :name, :url, :short_url, to: :@user
  delegate :followers, :following, :stars, :contributions, :username,
           :organization, :localization, :image_url, to: :@github_profile, prefix: :github
  delegate :followers_message, :following_message, :stars_message, :contributions_message,
           :organization, :localization, to: :@github_profile_property, prefix: :github

  def initialize(db_user:)
    @user                    = db_user
    @github_profile          = @user&.github_profile
    @page_navigation         = UserPresenters::PageNavigation.new(db_user: db_user)
    @github_profile_property = UserPresenters::GithubProfileProperty.new(github_profile: @github_profile)
  end

  def github_username_message
    h.t('users.show.github_username', username: github_profile.username)
  end

  def last_updated_at
    h.t('users.show.last_updated_at', last_update: h.l(user.updated_at))
  end

  def last_github_scrapping_update
    h.t('users.show.last_syncronized_at', last_update: h.l(user.github_profile.updated_at))
  end

  private

  attr_reader :user, :github_profile
end
