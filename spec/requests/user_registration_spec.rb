require 'rails_helper'

RSpec.describe 'User Registration', type: :request, bitly_fake_response: true, github_fake_response: true do
  include CustomMatchers::RequestResponse

  describe 'POST /create' do
    context 'when succeds' do
      let(:valid_user_form) do
        {
          name: Faker::Name.name_with_middle,
          url: Faker::Internet.url(host: 'github.com/hugohernani')
        }
      end

      it 'redirects to user page' do
        post '/user_registration', params: { github_user_registration_form: valid_user_form }

        user_redirected_path = user_path(User.last)

        expect(response).to have_responded_as(:redirect, redirect_path: user_redirected_path)
      end
    end

    context 'when fails' do
      let(:invalid_user_form) do
        {
          name: Faker::Name.name_with_middle,
          url: nil
        }
      end

      it 'redirects to user page' do
        post '/user_registration', params: { github_user_registration_form: invalid_user_form }

        expect(response).to have_responded_as(:success, on_view: :new, with_assigns: :form)
      end
    end
  end
end
