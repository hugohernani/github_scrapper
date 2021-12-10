class ListenerSubscription
  def initialize(publisher:, listeners: [])
    @publisher = publisher
    @listeners = Array(listeners)
  end

  def subscribe
    listeners.each do |listener|
      publisher.subscribe(listener)
    end
  end

  private

  attr_reader :publisher, :listeners
end
