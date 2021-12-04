class UserForm
  include ActiveModel::Model

  attr_accessor :name, :url

  validates :name, :url, presence: true
end
