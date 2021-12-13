class User < ApplicationRecord
  include RansackObjectForLowercase

  EVENTS = {
    'updated' => 'user_updated',
    'profile_updated' => 'user_profile_updated'
  }.freeze

  has_one :github_profile, class_name: 'GithubProfile', dependent: :destroy

  default_scope ->{ order(created_at: :desc) }
  scope :with_github_profile, ->{ includes(:github_profile) }

  class << self
    include Wisper::Publisher

    def persist(form_model)
      create(name: form_model.name, url: form_model.url)
    end

    def add_short_url(user_id:, short_url:)
      user = find(user_id)
      broadcast(User::EVENTS['updated'], user: user) if user.update(short_url: short_url)
    end

    def update_from_form(user, form_model)
      broadcast(User::EVENTS['updated'], user: user) if user.update(name: form_model.name, url: form_model.url)
    end

    def persist_github_profile(user_id:, profile:)
      user           = User.find(user_id)
      github_profile = user.github_profile || user.build_github_profile(user_id: user_id)
      persisted_github_profile(github_profile, profile)
      broadcast(User::EVENTS['profile_updated'], user: user) if github_profile.persisted?
    end

    private

    def persisted_github_profile(github_profile, profile)
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
end
