require 'nokogiri'

module WebScrapper
  class NokogiriProfileParser
    def initialize
      @nokogiri = Nokogiri::HTML
    end

    def parse(raw_html)
      node              = nokogiri.parse(raw_html)
      username          = nickname_value(node)
      extracted_numbers = NokogiriProfileParsers::NumberExtraction.new(node).extract
      image_url         = image_source_value(node)
      organization      = extract_organization(node)
      localization      = extract_localization(node)
      construct_profile(username, extracted_numbers, image_url, organization, localization)
    end

    private

    attr_reader :nokogiri

    def nickname_value(node)
      node.at_css('span.p-nickname')&.text&.strip
    end

    def image_source_value(node)
      image_node = node.at_css('div.js-profile-editable-replace img.avatar-user')
      image_node&.attr('src')
    end

    def extract_organization(node)
      organization_element = node.at_css("div.js-profile-editable-replace a[data-hovercard-type='organization']")
      return if organization_element.blank?

      organization_element.text.scan(/\w+/).join
    end

    def extract_localization(node)
      node.at_css("div.js-profile-editable-replace li.vcard-detail[itemprop='homeLocation'] span")&.text
    end

    def construct_profile(username, extracted_numbers, image_url, organization, localization)
      OpenStruct.new(
        username: username,
        followers: extracted_numbers.followers_count,
        following: extracted_numbers.following_count,
        stars: extracted_numbers.stars_count,
        contributions: extracted_numbers.contributions_count,
        image_url: image_url,
        organization: organization,
        localization: localization
      )
    end
  end
end
