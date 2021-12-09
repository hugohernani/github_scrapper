require 'rails_helper'

describe 'User Details View', type: :feature, **Utils.mocked_server_flags do
  let(:db_user){ create(:user, :with_github_profile) }

  it 'confirms user and github profile details are present on view' do
    visit "/users/#{db_user.id}"

    expect(page).to have_primary_user_details(db_user)
    expect(page).to have_primary_user_action_links(db_user)

    expect(page).to have_github_profile_details(db_user.github_profile)
    expect(page).to have_github_profile_syncronize_link(db_user)
  end

  matcher :have_primary_user_details do |given_user|
    match do |actual_page|
      expect(actual_page).to have_text(given_user.name)
    end
  end

  matcher :have_primary_user_action_links do |given_user|
    match do |actual_page|
      page_navigation = UserPresenters::PageNavigation.new(db_user: given_user)

      have_edit_link(actual_page, page_navigation.edit_user_link) &&
        have_delete_link(actual_page, page_navigation.user_link)
    end

    def have_edit_link(page, link_url)
      expect(page).to have_link(I18n.t('helpers.buttons.edit'), href: link_url)
    end

    def have_delete_link(page, link_url)
      expect(page).to have_link(I18n.t('helpers.buttons.delete'), href: link_url)
    end
  end

  matcher :have_github_profile_details do |given_github_profile|
    match do |actual_page|

      [:followers, :following, :stars, :contributions, :organization, :localization].all? do |attribute|
        have_attribute(actual_page, given_github_profile.send(attribute))
      end
    end

    def have_attribute(page, attribute)
      expect(page).to have_text(attribute)
    end
  end

  matcher :have_github_profile_syncronize_link do |given_user|
    match do |actual_page|
      page_navigation = UserPresenters::PageNavigation.new(db_user: given_user)

      expect(actual_page).to have_link(I18n.t('helpers.buttons.syncronize'), href: page_navigation.refresh_profile_page_link)
    end
  end
end
