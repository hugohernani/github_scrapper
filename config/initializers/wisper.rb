Rails.application.reloader.to_prepare do
  ListenerSubscription.new(publisher: User, listeners: [
                             Users::TurboBroadcasting.new
                           ]).subscribe
end
