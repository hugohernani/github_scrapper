module Github
  module UserScrappingEnqueuer
    def enqueue_default_scrapping(link_shorten:, web_scrapper:, target_url:, user_id:)
      Github::DefaultUserScrappingJob.perform_later(
        link_shorten_class: link_shorten.class,
        web_scrapper_class: web_scrapper.class,
        target_url: target_url,
        user_id: user_id
      )
    end
  end
end
