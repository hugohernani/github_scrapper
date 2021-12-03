require 'rails_helper'

describe WebScrapper::GithubProfile do
  subject(:scrapper){ described_class.new(crawler: crawler, parser: parser) }

  let(:raw_html_data){ '<html></html>' }
  let(:crawler){ double(:crawler, perform: raw_html_data) }
  let(:parser){ double(:parser, parse: nil) }

  let(:url){ Faker::Internet.url(host: 'github.com/hugohernani') }

  it 'delegates to crawler the responsibility for loading content' do
    scrapper.load_data(url: url)

    expect(crawler).to have_received(:perform).with(url)
  end

  it 'delegates to parser the responsibility for transforming raw html data' do
    scrapper.load_data(url: url)

    expect(parser).to have_received(:parse).with(be_a(String))
  end
end
