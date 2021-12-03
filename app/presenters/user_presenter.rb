class UserPresenter
  delegate :name, :url, :short_url, to: :@user
  delegate :username, :followers, :following, :stars, :contributions, :image_url,
           to: :@github_profile, prefix: :github

  def initialize(db_user:)
    @user           = db_user
    @github_profile = @user.github_profile
  end

  private

  attr_reader :user, :github_profile
end
