class User < ApplicationRecord
  include RansackObjectForLowercase

  has_one :github_profile, class_name: 'GithubProfile', dependent: :destroy

  scope :with_github_profile, ->{ includes(:github_profile) }

  def self.add_short_url(user_id:, short_url:)
    where(id: user_id).update_all(short_url: short_url)
  end

  def self.persist_github_profile(user_id:, profile:)
    github_profile = GithubProfile.find_or_create_by(user_id: user_id)
    github_profile.update(
      username: profile.username,
      followers: profile.followers,
      following: profile.following,
      stars: profile.stars,
      contributions: profile.contributions,
      image_url: profile.image_url,
      organization: profile.organization,
      localization: profile.localization
    )
  end
end
