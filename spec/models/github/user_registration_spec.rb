require 'rails_helper'

describe Github::UserRegistration, github_fake_response: true do
  subject(:registration){ described_class.new(user_form, link_shorten: mocked_shorten_link) }

  let(:fake_short_url){ Faker::Internet.url(host: 'bit.ly') }
  let(:mocked_shorten_link){ double(:mocked_shorten_link, generate: fake_short_url) }

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

    it 'updates short_url from returned fake short url on created user' do
      registration.create

      user = User.last
      expect(user.short_url).to eq(fake_short_url)
    end
  end

  describe 'using external services' do
    it 'delegates shortening to given shorten service ' do
      registration.create

      expect(mocked_shorten_link).to have_received(:generate).with(url: user_form.url)
    end

    context 'when scraping profile data' do
      subject(:registration) do
        described_class.new(user_form, link_shorten: mocked_shorten_link, web_scrapper: fake_web_scrapper)
      end

      let(:profile_data) do
        OpenStruct.new(attributes_for(:github_profile))
      end
      let(:fake_web_scrapper){ instance_double('WebScrapper::GithubProfile', load_data: profile_data) }

      it 'creates a GithubProfile database record with incoming data from webscrapper' do
        registration.create

        created_github_profile = GithubProfile.last
        expect(created_github_profile).to have_attributes({
                                                            username: profile_data.username,
                                                            followers: profile_data.followers,
                                                            following: profile_data.following,
                                                            stars: profile_data.stars,
                                                            contributions: profile_data.contributions,
                                                            image_url: profile_data.image_url
                                                          })
      end
    end
  end
end
