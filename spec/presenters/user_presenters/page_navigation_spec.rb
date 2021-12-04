require 'rails_helper'

describe UserPresenters::PageNavigation do
  subject(:presenter){ described_class.new(db_user: db_user) }

  let(:db_user){ create(:user, :with_github_profile) }

  it 'returns url to refresh github data' do
    expected_url = "/users/#{db_user.id}/github_scrapper"
    expect(presenter.refresh_profile_page_url).to eq(expected_url)
  end

  it 'returns url to update user' do
    expect(presenter.update_page_url).to eq("/users/#{db_user.id}")
  end
end
