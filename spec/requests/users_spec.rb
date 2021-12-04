require 'rails_helper'

RSpec.describe 'Users', type: :request, bitly_fake_response: true, github_fake_response: true do
  include CustomMatchers::RequestResponse

  describe 'GET /show' do
    let(:user){ create(:user, :with_github_profile) }

    context 'when succeeds' do
      it 'successfully returns show view with assigned user' do
        get "/users/#{user.id}"

        expect(response).to have_responded_as(:success, on_view: :show, with_assigns: :user)
      end
    end

    context 'when fails' do
      let(:non_existent_user){ instance_double('User', id: 42) }

      it 'returns not found result' do
        get "/users/#{non_existent_user.id}"

        expect(response).to have_responded_as(:not_found, redirect_path: root_path)
      end
    end
  end

  describe 'POST /create' do
    context 'when succeds' do
      let(:valid_user_form) do
        {
          name: Faker::Name.name_with_middle,
          url: Faker::Internet.url(host: 'github.com/hugohernani')
        }
      end

      it 'redirects to user page' do
        post '/users', params: { user_form: valid_user_form }

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
        post '/users', params: { user_form: invalid_user_form }

        expect(response).to have_responded_as(:success, on_view: :new, with_assigns: :form)
      end
    end
  end
end
