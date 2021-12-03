class User < ApplicationRecord
  def self.add_short_url(user_id:, short_url:)
    where(id: user_id).update_all(short_url: short_url)
  end
end
