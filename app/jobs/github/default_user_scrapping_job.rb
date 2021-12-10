class Github::DefaultUserScrappingJob < ApplicationJob
  queue_as :default

  def perform(link_shorten_class:, web_scrapper_class:, target_url:, user_id:)
    Github::DefaultUserScrappingFacade.new(
      link_shorten: link_shorten_class.new,
      web_scrapper: web_scrapper_class.new
    ).perform(target_url: target_url, user_id: user_id)
  end
end
