class CreateGithubProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :github_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :username
      t.integer :followers
      t.integer :following
      t.integer :stars
      t.integer :contributions
      t.string :image_url

      t.timestamps
    end
  end
end
