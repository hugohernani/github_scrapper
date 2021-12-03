require 'rails_helper'

RSpec.describe User, type: :model do
  it 'updates user with with given short url' do
    user = create(:user)
    short_url = Faker::Internet.url(host: 'bit.ly')

    expect do
      User.add_short_url(user_id: user.id, short_url: short_url)
    end.to change{ user.reload.short_url }.to(short_url)
  end

  describe 'associations' do
    it { is_expected.to have_one(:github_profile) }
  end
end
