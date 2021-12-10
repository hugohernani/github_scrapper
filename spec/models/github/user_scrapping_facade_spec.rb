require 'rails_helper'

describe Github::UserScrappingFacade do
  subject(:facade){ described_class.new(link_shorten: link_shorten, web_scrapper: web_scrapper) }

  let(:link_shorten){ double(:link_shorten) }
  let(:web_scrapper){ nil }
  let(:short_url){ Faker::Internet.url(host: 'bit.ly') }

  before do
    allow(link_shorten).to receive(:generate).and_return(short_url)
    allow(User).to receive(:add_short_url)
    allow(WebScrapper::GithubProfileLoader).to receive_message_chain(:new, :load_onto_user)
  end

  it 'delegates shortening link to link_shorten' do
    url = Faker::Internet.url
    facade.perform(target_url: url, user_id: nil)

    expect(link_shorten).to have_received(:generate).with(url: url)
  end

  it 'delegates updating user with short_url to User class' do
    user_id = 42
    facade.perform(target_url: nil, user_id: user_id)

    expect(User).to have_received(:add_short_url).with(user_id: user_id, short_url: short_url)
  end

  it 'delegates webscrapping github profile' do
    user_id = 42
    facade.perform(target_url: nil, user_id: user_id)

    expect(WebScrapper::GithubProfileLoader).to have_received(:new).with(user_id: user_id, web_scrapper: web_scrapper)
  end
end
