module Shortner
  module BitlyErrors
    class MissingApiToken < StandardError
      def initialize(message = 'Missing api token for Bitly api')
        super(message)
      end
    end
  end
end
