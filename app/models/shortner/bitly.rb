module Shortner
  class Bitly
    include Base

    def initialize(url:, api_wrapper:)
      super(url: url)
      @shortner_api = api_wrapper
    end

    def generate
      shortner_api.shorten(long_url: url)
    end

    private

    attr_reader :shortner_api
  end
end
