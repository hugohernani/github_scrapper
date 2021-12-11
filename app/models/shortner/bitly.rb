module Shortner
  class Bitly < Base
    def initialize(api_wrapper: default_bitly_api_wrapper)
      @shortner_api = api_wrapper
    end

    def generate(url:)
      bitly = shortner_api.shorten(long_url: url)
      bitly.link
    rescue ::Bitly::Error => _e
      raise BitlyErrors::GenericError
    end

    private

    attr_reader :shortner_api

    def default_bitly_api_wrapper
      bitly_api_token = ENV['BITLY_API_TOKEN']
      raise Shortner::BitlyErrors::MissingBitlyApiToken if bitly_api_token.blank?

      ::Bitly::API::Client.new(token: bitly_api_token)
    end
  end
end
