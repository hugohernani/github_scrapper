require 'rails_helper'

describe Shortner::FakeBitly do
  subject(:shortner){ described_class.new }

  let(:url){ Faker::Internet.url(host: 'github.com') }

  it 'delegates call to original bitly server' do
    bitly_shortner = instance_double('Shortner::Bitly', generate: nil)
    allow(Shortner::Bitly).to receive(:new).and_return(bitly_shortner)

    shortner.generate(url: url)

    expect(bitly_shortner).to have_received(:generate).with(url: url)
  end

  it 'gives back a short link according to the response given by mocked server' do
    bitly_link_response = Utils.fixture_file('bitly_content/bitly_create_link_response.json')
    fake_bitly_response_link = JSON.parse(bitly_link_response)['link']

    short_link = shortner.generate(url: url)

    expect(short_link).to eq(fake_bitly_response_link)
  end
end
