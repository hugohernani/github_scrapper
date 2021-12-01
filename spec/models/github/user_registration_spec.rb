require 'rails_helper'

describe Github::UserRegistration do
  subject(:registration){ described_class.new(user_form, link_shorten: mocked_shorten_link) }

  let(:mocked_shorten_link){ double(:mocked_shorten_link, generate: nil) }

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

  describe 'generation of a short link' do
    it 'delegates shortening to given shorten service ' do
      registration.create

      expect(mocked_shorten_link).to have_received(:generate).with(url: user_form.url)
    end
  end
end
