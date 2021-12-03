require 'rails_helper'

stub_flags = {
  github_fake_response: true,
  bitly_fake_response: true
}

describe 'Github WebScrapper on User Registration', type: :system, **stub_flags do
  it 'creates an user from fulfilled form' do
    visit '/user_registration/new'

    fill_creation_form

    click_button I18n.t('helpers.buttons.submit')

    expect(page).to have_text(I18n.t('user_registration.create.success'))
  end

  def fill_creation_form
    fill_in 'github_user_registration_form_name', with: Faker::Name.name_with_middle
    fill_in 'github_user_registration_form_url', with: Faker::Internet.url(host: 'github.com')
  end
end
