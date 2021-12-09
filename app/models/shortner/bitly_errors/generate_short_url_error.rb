module Shortner
  module BitlyErrors
    class GenerateShortUrlError < StandardError
      def initialize(message = 'Something went wrong when generating url')
        super(message)
      end
    end
  end
end
