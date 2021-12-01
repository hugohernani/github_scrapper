require 'rails_helper'

describe Github::UserRegistration do
  subject(:registration){ described_class.new(user_form) }

  let(:user_form) do
    GithubUserRegistrationForm.new(
      name: 'Jack Sparrow', url: 'http://github.com/hugohernani'
    )
  end

  describe 'creation of an user from given form' do
    it 'registers it into database' do
      expect do
        registration.create
      end.to change(User, :count)
    end
  end
end
