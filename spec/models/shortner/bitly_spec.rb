require 'rails_helper'

describe Shortner::Bitly do
  subject(:shortner){ described_class.new(url: url, api_wrapper: mocked_api_wrapper) }

  let(:url){ Faker::Internet.url(host: 'github.com') }
  let(:bitly_instance){ double(:bitly_instance, link: 'bit.ly/short') }
  let(:mocked_api_wrapper){ double(:mocked_api_wrapper, shorten: bitly_instance) }

  it 'talks to api wrapper to short given url' do
    shortner.generate

    expect(mocked_api_wrapper).to have_received(:shorten).with(long_url: url)
  end

  it 'gives back a short link for given long url' do
    short_link = shortner.generate

    expect(short_link).to eq(bitly_instance.link)
  end
end
