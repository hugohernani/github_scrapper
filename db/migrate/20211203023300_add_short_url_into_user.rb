class AddShortUrlIntoUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :short_url, :string
  end
end
