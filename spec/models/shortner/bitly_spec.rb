require 'rails_helper'

describe Shortner::Bitly do
  subject(:shortner){ described_class.new(url: url, api_wrapper: mocked_api_wrapper) }

  let(:url){ Faker::Internet.url(host: 'github.com') }
  let(:mocked_api_wrapper){ double(:mocked_api_wrapper, shorten: nil) }

  it 'talks to api wrapper to short given url' do
    shortner.generate

    expect(mocked_api_wrapper).to have_received(:shorten).with(long_url: url)
  end
end
