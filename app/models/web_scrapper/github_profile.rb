module WebScrapper
  class GithubProfile
    def initialize(crawler: FaradayCrawler.new, parser: NokogiriProfileParser.new)
      @crawler   = crawler
      @parser    = parser
    end

    def load_data(url:)
      raw_html = crawler.perform(url)
      parser.parse(raw_html)
    end

    private

    attr_reader :crawler, :parser, :extractor
  end
end
