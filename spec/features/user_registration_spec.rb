require 'rails_helper'

describe 'User Registration', type: :feature, **Utils.mocked_server_flags do
  it 'creates an user from fulfilled form' do
    visit '/users/new'

    Forms::UserFullfillment.new(self).fill_form

    click_button I18n.t('helpers.buttons.submit')

    expect(page).to have_text(I18n.t('users.create.success'))
  end
end
