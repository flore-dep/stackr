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

ActiveRecord::Schema[7.1].define(version: 2025_03_13_104559) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "licenses", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "access_type"
    t.bigint "plan_id", null: false
    t.bigint "user_id", null: false
    t.bigint "scope_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_licenses_on_plan_id"
    t.index ["scope_id"], name: "index_licenses_on_scope_id"
    t.index ["user_id"], name: "index_licenses_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "plans", force: :cascade do |t|
    t.jsonb "formula", default: {}
    t.string "status"
    t.bigint "organization_id", null: false
    t.bigint "tool_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_plans_on_organization_id"
    t.index ["tool_id"], name: "index_plans_on_tool_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "username"
    t.text "content"
    t.integer "rating"
    t.bigint "tool_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tool_id"], name: "index_reviews_on_tool_id"
  end

  create_table "scopes", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_scopes_on_plan_id"
    t.index ["team_id"], name: "index_scopes_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_teams_on_organization_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.jsonb "formulas", default: "{\"free\":0,\"business\":15,\"enterprise\":50}"
    t.string "access_types", default: ["User", "Admin"], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "long_description"
    t.string "website"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.date "start_date"
    t.date "end_date"
    t.bigint "team_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "licenses", "plans"
  add_foreign_key "licenses", "scopes"
  add_foreign_key "licenses", "users"
  add_foreign_key "plans", "organizations"
  add_foreign_key "plans", "tools"
  add_foreign_key "reviews", "tools"
  add_foreign_key "scopes", "plans"
  add_foreign_key "scopes", "teams"
  add_foreign_key "teams", "organizations"
  add_foreign_key "users", "teams"
end
