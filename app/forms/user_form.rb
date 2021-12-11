class UserForm
  include ActiveModel::Model

  attr_accessor :name, :url

  validates :name, :url, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
