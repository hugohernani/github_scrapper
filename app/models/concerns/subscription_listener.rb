module SubscriptionListener
  def subscribe(listeners: [], on_publisher: self)
    ListenerSubscription.new(publisher: on_publisher, listeners: listeners).subscribe
  end
end
