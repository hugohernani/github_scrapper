require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include CustomMatchers::RequestResponse

  let(:user){ create(:user) }

  describe 'GET /show' do
    it 'returns http success' do
      get "/user/#{user.id}"

      expect(response).to have_responded_as(:success, on_view: :show, with_assigns: :user)
    end
  end
end
