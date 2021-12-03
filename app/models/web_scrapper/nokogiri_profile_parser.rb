require 'nokogiri'

module WebScrapper
  class NokogiriProfileParser
    def initialize
      @nokogiri = Nokogiri::HTML
    end

    def parse(raw_html)
      node                = nokogiri.parse(raw_html)
      username            = nickname_value(node)
      followers_count     = extract_number_on_profile_link(node, 'followers')
      following_count     = extract_number_on_profile_link(node, 'following')
      stars_count         = extract_number_on_profile_link(node, 'stars')
      contributions_count = contributions_number(node)
      image_url           = image_source_value(node)
      # TODO: parse optional organizations and localization
      construct_profile(username, followers_count, following_count,
                        stars_count, contributions_count, image_url)
    end

    private

    attr_reader :nokogiri

    def nickname_value(node)
      node.css('span.p-nickname').text.strip
    end

    def extract_number_on_profile_link(node, href_key)
      node_match_number(node, "div.js-profile-editable-area a[href*='#{href_key}']")
    end

    def contributions_number(node)
      node_match_number(node, 'div.js-yearly-contributions h2')
    end

    def image_source_value(node)
      image_node = node.at_css('div.js-profile-editable-replace img.avatar-user')
      image_node.attr('src')
    end

    def construct_profile(username, followers_count, following_count, stars_count, contributions_count, image_url)
      OpenStruct.new(
        username: username,
        followers: followers_count,
        following: following_count,
        stars: stars_count,
        contributions: contributions_count,
        image_url: image_url
      )
    end

    def node_match_number(node, selector)
      selector_node = node.at_css(selector)
      node_value    = selector_node.text
      raw_number    = node_value.scan(/\d/).join
      Integer(raw_number)
    end
  end
end
