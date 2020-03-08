# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_01_160943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.string "controller", null: false
    t.string "action", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actions_profiles", id: false, force: :cascade do |t|
    t.bigint "action_id", null: false
    t.bigint "profile_id", null: false
    t.index ["action_id", "profile_id"], name: "index_actions_profiles_on_action_id_and_profile_id"
    t.index ["profile_id", "action_id"], name: "index_actions_profiles_on_profile_id_and_action_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.boolean "custom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.index ["profile_id", "user_id"], name: "index_profiles_users_on_profile_id_and_user_id"
    t.index ["user_id", "profile_id"], name: "index_profiles_users_on_user_id_and_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname", null: false
    t.string "registration"
    t.string "cpf", null: false
    t.string "email", null: false
    t.string "cellphone"
    t.datetime "date_of_birth", null: false
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
