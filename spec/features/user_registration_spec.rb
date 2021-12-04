require 'rails_helper'

stub_flags = {
  github_fake_response: true,
  bitly_fake_response: true
}

describe 'Github WebScrapper on User Registration', type: :feature, **stub_flags do
  it 'creates an user from fulfilled form' do
    visit '/users/new'

    Forms::UserFullfillment.new(self).fill_form

    click_button I18n.t('helpers.buttons.submit')

    expect(page).to have_text(I18n.t('user_registration.create.success'))
  end
end
