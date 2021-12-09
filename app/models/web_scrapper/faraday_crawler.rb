require 'faraday'

module WebScrapper
  class FaradayCrawler
    def initialize(adapter: :net_http)
      @connection = Faraday.new do |conn|
        conn.adapter(adapter)
      end
    end

    def perform(url)
      response = connection.get(url)
      response.body
    end

    private

    attr_reader :connection
  end
end
