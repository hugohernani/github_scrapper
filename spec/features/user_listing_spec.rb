require 'rails_helper'

describe 'User Listing View', type: :feature do
  include CustomMatchers::UserListing

  let!(:users){ create_list(:user, 2, :with_github_profile) }

  it 'confirms that user primary info is present on view' do
    visit '/users/'

    expect(page).to have_table_row_with_primary_info(users.first)
  end

  it 'confirms that action buttons are present on view' do

    visit '/users/'

    expect(page).to have_action_buttons_on_user_row(users.first)
  end
end
