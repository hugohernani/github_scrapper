WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: 'chromedriver.storage.googleapis.com'
)

RSpec.configure do |config|
  config.before do |example|
    stub_request(:any, /github.com/).to_rack(FakeGitHub) if example.metadata[:github_fake_response]
    stub_request(:any, /api-ssl.bitly.com/).to_rack(FakeBitlyServer) if example.metadata[:bitly_fake_response]
  end
end
