module Users
  class TurboBroadcasting
    def user_updated(data)
      user = data.fetch(:user)
      Rails.logger.info 'User Updated: '
      Rails.logger.info user
    end

    def user_profile_updated(data)
      user = data.fetch(:user)
      Rails.logger.info 'User Profile Updated: '
      Rails.logger.info user.github_profile
    end
  end
end
