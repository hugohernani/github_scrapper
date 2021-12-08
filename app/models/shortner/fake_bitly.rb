require 'webmock'

module Shortner
  class FakeBitly < Base
    def initialize(fake_bitly_server: FakeBitlyServer)
      mock_bitly_requests(fake_bitly_server)
      @real_bitly_shortner = Shortner::Bitly.new
    end

    def generate(url:)
      real_bitly_shortner.generate(url: url)
    end

    private

    attr_reader :real_bitly_shortner

    def mock_bitly_requests(bitly_server)
      WebMock.disable_net_connect!(allow_localhost: true)
      WebMock.stub_request(:any, /api-ssl.bitly.com/).to_rack(bitly_server)
    end
  end
end
