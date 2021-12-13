Rails.application.reloader.to_prepare do
  ListenerSubscription.new(publisher: Users::EventNotification, listeners: [
                             Users::TurboBroadcasting.new
                           ]).subscribe
end
