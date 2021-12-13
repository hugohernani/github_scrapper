class UserPresenter < BasePresenter
  attr_accessor :page_navigation

  delegate :id, :name, :url, :short_url, :to_gid_param, :to_key, :model_name, to: :@user
  delegate :followers, :following, :stars, :contributions, :username,
           :organization, :localization, :image_url, to: :@github_profile, prefix: :github, allow_nil: true
  delegate :followers_message, :following_message, :stars_message, :contributions_message,
           :organization, :localization, to: :@github_profile_property, prefix: :github, allow_nil: true

  def initialize(db_user:)
    @user                    = db_user
    @github_profile          = @user.github_profile
    @page_navigation         = UserPresenters::PageNavigation.new(db_user: db_user)
    @github_profile_property = UserPresenters::GithubProfileProperty.new(github_profile: @github_profile)
  end

  def github_username_message
    return UserPresenters::NullProperty.new('username') unless github_profile

    h.t('users.show.github_username', username: github_profile&.username)
  end

  def last_updated_at
    h.t('users.show.last_updated_at', last_update: h.l(user.updated_at))
  end

  def last_github_scrapping_update
    return h.t('users.show.not_synced_yet') if user.github_profile.nil?

    h.t('users.show.last_syncronized_at', last_update: h.l(user.github_profile.updated_at))
  end

  private

  attr_reader :user, :github_profile
end
