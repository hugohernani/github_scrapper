class ListenerSubscription
  def initialize(publisher:, listeners: [])
    @publisher = publisher
    @listeners = Array(listeners)
  end

  def subscribe
    listeners.each do |listener|
      unless already_added_listener?(listener)
        publisher.subscribe(listener)
        log_subscription(listener)
      end
    end
  end

  private

  attr_reader :publisher, :listeners

  def already_added_listener?(incoming_listener)
    publisher.any? do |listener|
      incoming_listener.is_a?(listener.class)
    end
  end

  def log_subscription(listener)
    Rails.logger.info("#{listener} is being subscribed onto #{@publisher}")
  end
end
