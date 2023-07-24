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

ActiveRecord::Schema[7.0].define(version: 2023_07_24_080610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ruby_methods", force: :cascade do |t|
    t.bigint "ruby_module_id", null: false
    t.string "name", null: false
    t.string "official_url", default: "https://docs.ruby-lang.org/ja/latest/library/_builtin.html", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ruby_module_id"], name: "index_ruby_methods_on_ruby_module_id"
  end

  create_table "ruby_modules", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_ruby_methods", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ruby_method_id", null: false
    t.text "memo"
    t.boolean "remembered", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ruby_method_id"], name: "index_user_ruby_methods_on_ruby_method_id"
    t.index ["user_id"], name: "index_user_ruby_methods_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "provider", null: false
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "ruby_methods", "ruby_modules"
  add_foreign_key "user_ruby_methods", "ruby_methods"
  add_foreign_key "user_ruby_methods", "users"
end
