class AddOrgAndLocalizationIntoGithubProfile < ActiveRecord::Migration[6.1]
  def change
    change_table :github_profiles, bulk: true do |t|
      t.string :organization
      t.string :localization
    end
  end
end
