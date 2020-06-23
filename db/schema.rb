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

ActiveRecord::Schema.define(version: 2020_06_22_221921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archives", force: :cascade do |t|
    t.string "origin_type", null: false
    t.bigint "origin_id", null: false
    t.string "name", null: false
    t.binary "content", null: false
    t.string "format", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin_type", "origin_id"], name: "index_archives_on_origin_type_and_origin_id"
  end

  create_table "certificate_signatures", force: :cascade do |t|
    t.string "name", null: false
    t.string "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "image_id", null: false
  end

  create_table "certificate_signatures_templates", id: false, force: :cascade do |t|
    t.bigint "certificate_template_id", null: false
    t.bigint "certificate_signature_id", null: false
  end

  create_table "certificate_templates", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "image_id", null: false
    t.bigint "person_id", null: false
    t.bigint "event_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "default", default: false
    t.index ["event_category_id"], name: "index_certificate_templates_on_event_category_id"
    t.index ["image_id"], name: "index_certificate_templates_on_image_id"
    t.index ["person_id"], name: "index_certificate_templates_on_person_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number_of_semesters", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_categories", force: :cascade do |t|
    t.string "name"
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_requests", force: :cascade do |t|
    t.text "additional_information"
    t.bigint "person_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "situation_id"
    t.index ["situation_id"], name: "index_event_requests_on_situation_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_date", null: false
    t.datetime "closing_date", null: false
    t.bigint "event_category_id", null: false
    t.bigint "image_id"
    t.integer "workload", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_id"
    t.boolean "own_certificate", default: false
    t.bigint "certificate_template_id", null: false
    t.bigint "situation_id"
    t.index ["certificate_template_id"], name: "index_events_on_certificate_template_id"
    t.index ["situation_id"], name: "index_events_on_situation_id"
  end

  create_table "events_oriented_activities", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "oriented_activity_id", null: false
  end

  create_table "frequences", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_frequences_on_event_id"
  end

  create_table "guideds", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "course_id", null: false
    t.bigint "semester", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "guideds_oriented_activities", id: false, force: :cascade do |t|
    t.bigint "oriented_activity_id", null: false
    t.bigint "guided_id", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "format", null: false
    t.binary "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "key_situations", force: :cascade do |t|
    t.string "key", null: false
    t.string "description"
    t.string "description_female"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "oriented_activities", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "event_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "oriented_activities_people", id: false, force: :cascade do |t|
    t.bigint "oriented_activity_id", null: false
    t.bigint "person_id", null: false
    t.index ["oriented_activity_id"], name: "index_oriented_activities_people_on_oriented_activity_id"
    t.index ["person_id"], name: "index_oriented_activities_people_on_person_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "frequence_id"
    t.bigint "type_participation_id"
    t.bigint "event_id"
    t.string "email"
    t.string "name"
    t.string "surname"
    t.string "registration"
    t.string "cpf"
    t.integer "status"
    t.integer "workload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_participants_on_event_id"
    t.index ["frequence_id"], name: "index_participants_on_frequence_id"
    t.index ["type_participation_id"], name: "index_participants_on_type_participation_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "registration"
    t.string "cpf", null: false
    t.string "name", null: false
    t.string "surname"
    t.string "cellphone"
    t.datetime "date_of_birth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.string "controller", null: false
    t.string "action", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "public", default: false
  end

  create_table "permissions_profiles", id: false, force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "profile_id", null: false
    t.index ["permission_id", "profile_id"], name: "index_permissions_profiles_on_permission_id_and_profile_id"
    t.index ["profile_id", "permission_id"], name: "index_permissions_profiles_on_profile_id_and_permission_id"
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

  create_table "situations", force: :cascade do |t|
    t.bigint "key_situation_id", null: false
    t.text "observation"
    t.string "origin_type", null: false
    t.bigint "origin_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_situation_id"], name: "index_situations_on_key_situation_id"
    t.index ["origin_type", "origin_id"], name: "index_situations_on_origin_type_and_origin_id"
    t.index ["person_id"], name: "index_situations_on_person_id"
  end

  create_table "type_participations", force: :cascade do |t|
    t.string "name", null: false
    t.string "key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.bigint "person_id"
    t.boolean "incomplete_register", default: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "certificate_signatures", "images"
  add_foreign_key "certificate_signatures_templates", "certificate_signatures"
  add_foreign_key "certificate_signatures_templates", "certificate_templates"
  add_foreign_key "certificate_templates", "event_categories"
  add_foreign_key "certificate_templates", "images"
  add_foreign_key "certificate_templates", "people"
  add_foreign_key "event_requests", "situations"
  add_foreign_key "events", "certificate_templates"
  add_foreign_key "events", "event_categories"
  add_foreign_key "events", "events"
  add_foreign_key "events", "images"
  add_foreign_key "events", "situations"
  add_foreign_key "events_oriented_activities", "events"
  add_foreign_key "events_oriented_activities", "oriented_activities"
  add_foreign_key "frequences", "events"
  add_foreign_key "guideds", "people"
  add_foreign_key "guideds_oriented_activities", "guideds"
  add_foreign_key "guideds_oriented_activities", "oriented_activities"
  add_foreign_key "oriented_activities_people", "oriented_activities"
  add_foreign_key "oriented_activities_people", "people"
  add_foreign_key "participants", "events"
  add_foreign_key "participants", "frequences"
  add_foreign_key "participants", "type_participations"
  add_foreign_key "permissions_profiles", "permissions"
  add_foreign_key "permissions_profiles", "profiles"
  add_foreign_key "profiles_users", "profiles"
  add_foreign_key "profiles_users", "users"
  add_foreign_key "situations", "key_situations"
  add_foreign_key "situations", "people"
  add_foreign_key "users", "people"
end
