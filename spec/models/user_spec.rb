require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:github_profile) }
  end

  it 'updates user with with given short url' do
    user = create(:user)
    short_url = Faker::Internet.url(host: 'bit.ly')

    expect do
      User.add_short_url(user_id: user.id, short_url: short_url)
    end.to change{ user.reload.short_url }.to(short_url)
  end

  it 'creates a github profile when none exists' do
    user = create(:user)
    github_profile_attributes = build(:github_profile)

    expect do
      User.persist_github_profile(user_id: user.id, profile: github_profile_attributes)
    end.to change{ user.reload.github_profile }
      .from(nil)
      .to(be_a(GithubProfile))
  end
end
