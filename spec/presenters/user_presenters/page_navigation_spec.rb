require 'rails_helper'

describe UserPresenters::PageNavigation do
  subject(:presenter){ described_class.new(db_user: db_user) }

  let(:db_user){ create(:user, :with_github_profile) }

  it 'returns url to refresh github data' do
    expected_url = "/users/#{db_user.id}/github_scrapper"
    expect(presenter.refresh_profile_page_link).to eq(expected_url)
  end

  it 'returns url to edit user' do
    expect(presenter.edit_user_link).to eq("/users/#{db_user.id}/edit")
  end

  it 'returns url to access user' do
    expect(presenter.user_link).to eq("/users/#{db_user.id}")
  end
end
