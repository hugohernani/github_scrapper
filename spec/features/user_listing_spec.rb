require 'rails_helper'

describe 'User Listing View', type: :feature do
  let!(:users){ create_list(:user, 2, :with_github_profile) }

  it 'confirms that user primary info is present on view' do
    visit '/users/'

    expect(page).to have_table_row_with_primary_info(users.first)
  end

  matcher :have_table_row_with_primary_info do |given_user|
    match do |page|
      user_table_row = page.find(:css, "table.users-listing tbody tr##{given_user.id}")

      have_row(user_table_row) &&
        have_name(user_table_row, given_user.name) &&
        have_github_url(user_table_row, given_user.short_url)
    end

    def have_row(table_row)
      expect(table_row).not_to be_nil
    end

    def have_name(table_row, name)
      expect(table_row).to have_text(name)
    end

    def have_github_url(table_row, url)
      expect(table_row).to have_link(url, href: url)
    end
  end
end
