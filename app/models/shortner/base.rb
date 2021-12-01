module Shortner
  class Base
    def initialize(url)
      @url = url
    end

    def generate
      raise NotImplementedError, 'implementer should specify how short url will be generated'
    end

    protected

    attr_reader :url
  end
end
