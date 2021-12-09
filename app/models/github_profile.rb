class GithubProfile < ApplicationRecord
  include RansackObjectForLowercase

  belongs_to :user, class_name: 'User'
end
