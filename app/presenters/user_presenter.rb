class UserPresenter < BasePresenter
  attr_accessor :page_navigation

  delegate :name, :url, :short_url, to: :@user
  delegate :image_url, to: :@github_profile, prefix: :github
  delegate :followers, :following, :stars, :contributions,
           :organization, :localization, to: :@github_profile_counter, prefix: :github

  def initialize(db_user:)
    @user                   = db_user
    @github_profile         = @user.github_profile
    @page_navigation        = UserPresenters::PageNavigation.new(db_user: db_user)
    @github_profile_counter = UserPresenters::GithubProfileCounter.new(github_profile: @github_profile)
  end

  def github_username
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
