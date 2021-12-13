Rails.application.reloader.to_prepare do
  if ActiveRecord::Base.connection.table_exists? 'users'
    ListenerSubscription.new(publisher: User, listeners: [
                               Users::TurboBroadcasting.new
                             ]).subscribe
  end
end
