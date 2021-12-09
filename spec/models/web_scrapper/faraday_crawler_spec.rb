require 'rails_helper'

describe WebScrapper::FaradayCrawler, github_fake_response: true do
  subject(:crawler){ described_class.new }

  let(:url){ Faker::Internet.url(host: 'github.com') }

  it 'makes use of Faraday resource' do
    expect(Faraday).to receive(:new).and_call_original

    crawler.perform(url)
  end

  it 'returns a html content' do
    response = crawler.perform(url)

    html_wrap_regex = %r{<html.*</html>}m

    expect(response).to match(html_wrap_regex)
  end
end
