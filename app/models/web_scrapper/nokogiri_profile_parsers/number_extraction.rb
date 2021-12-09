module WebScrapper
  module NokogiriProfileParsers
    class NumberExtraction
      def initialize(node)
        @node = node
      end

      def extract
        OpenStruct.new(
          followers_count: extract_on_profile_link('followers'),
          following_count: extract_on_profile_link('following'),
          stars_count: extract_on_profile_link('stars'),
          contributions_count: contributions_number
        )
      end

      private

      attr_reader :node

      def extract_on_profile_link(href_key)
        node_match_number("div.js-profile-editable-area a[href*='#{href_key}']")
      end

      def contributions_number
        node_match_number('div.js-yearly-contributions h2')
      end

      def node_match_number(selector)
        count_node = node.at_css(selector)
        return if count_node.blank?

        node_value = count_node.text
        raw_number = node_value.scan(/\d/).join
        Integer(raw_number)
      end
    end
  end
end
