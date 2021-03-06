# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_05_023225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "github_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "username"
    t.integer "followers"
    t.integer "following"
    t.integer "stars"
    t.integer "contributions"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "organization"
    t.string "localization"
    t.index ["user_id"], name: "index_github_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "short_url"
  end

  add_foreign_key "github_profiles", "users"
end
