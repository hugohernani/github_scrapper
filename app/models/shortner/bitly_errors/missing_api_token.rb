module Shortner
  module BitlyErrors
    class MissingBitlyApiToken < StandardError
      def initialize(message = 'Missing api token for Bitly api')
        super(message)
      end
    end
  end
end
