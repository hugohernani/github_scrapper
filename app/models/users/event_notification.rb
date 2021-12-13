module Users
  class EventNotification
    EVENTS = {
      'updated' => 'user_updated',
      'profile_updated' => 'user_profile_updated'
    }.freeze

    class << self
      include Wisper::Publisher

      def notify_update(user_id:)
        user = User.find(user_id)
        broadcast(self::EVENTS['updated'], user: user)
      end

      def notify_profile_update(user_id:)
        user = User.find(user_id)
        broadcast(self::EVENTS['profile_updated'], user: user)
      end
    end
  end
end
