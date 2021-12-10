require 'rails_helper'

describe Github::UserRegistration, **Utils.mocked_server_flags do
  subject(:registration){ described_class.new(user_form) }

  let(:user_form) do
    UserForm.new(
      name: 'Jack Sparrow', url: 'http://github.com/hugohernani'
    )
  end

  describe 'user record registration' do
    it 'registers it into database' do
      expect do
        registration.create
      end.to change(User, :count)
    end
  end

  describe 'using networking services through activejob' do
    perform_enqueue_jobs

    it 'creates a GithubProfile and changes short_url on user' do
      registration.create

      user = registration.user

      expect do
        registration.create
        user.reload
      end.to change(GithubProfile, :count)
        .and change(user, :short_url)
    end
  end
end
