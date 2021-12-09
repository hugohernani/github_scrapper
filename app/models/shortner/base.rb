module Shortner
  class Base
    def generate(url:)
      raise NotImplementedError, 'implementer should specify how short url will be generated'
    end
  end
end
