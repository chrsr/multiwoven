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

ActiveRecord::Schema[7.1].define(version: 2024_09_23_150740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catalogs", force: :cascade do |t|
    t.integer "workspace_id"
    t.integer "connector_id"
    t.jsonb "catalog"
    t.string "catalog_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connectors", force: :cascade do |t|
    t.integer "workspace_id"
    t.integer "connector_type"
    t.integer "connector_definition_id"
    t.jsonb "configuration"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "connector_name"
    t.string "description"
    t.string "connector_category", default: "data", null: false
  end

  create_table "data_apps", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", null: false
    t.integer "workspace_id", null: false
    t.text "description"
    t.json "meta_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "data_app_token"
    t.index ["data_app_token"], name: "index_data_apps_on_data_app_token", unique: true
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.integer "workspace_id"
    t.integer "connector_id"
    t.text "query"
    t.integer "query_type"
    t.string "primary_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.jsonb "configuration"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "resources", force: :cascade do |t|
    t.string "resources_name"
    t.text "permissions", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.string "role_desc"
    t.jsonb "policies", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sync_records", force: :cascade do |t|
    t.integer "sync_id"
    t.integer "sync_run_id"
    t.jsonb "record"
    t.string "fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "action"
    t.string "primary_key"
    t.integer "status", default: 0
    t.jsonb "logs"
    t.index ["sync_id", "fingerprint"], name: "index_sync_records_on_sync_id_and_fingerprint", unique: true
    t.index ["sync_id", "primary_key"], name: "index_sync_records_on_sync_id_and_primary_key", unique: true
  end

  create_table "sync_runs", force: :cascade do |t|
    t.integer "sync_id"
    t.integer "status"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer "total_rows"
    t.integer "successful_rows"
    t.integer "failed_rows"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_offset", default: 0
    t.integer "workspace_id"
    t.integer "source_id"
    t.integer "destination_id"
    t.integer "model_id"
    t.integer "total_query_rows"
    t.datetime "discarded_at"
    t.integer "skipped_rows", default: 0
    t.integer "sync_run_type", default: 0
    t.index ["discarded_at"], name: "index_sync_runs_on_discarded_at"
  end

  create_table "syncs", force: :cascade do |t|
    t.integer "workspace_id"
    t.integer "source_id"
    t.integer "model_id"
    t.integer "destination_id"
    t.jsonb "configuration"
    t.integer "source_catalog_id"
    t.integer "schedule_type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_key"
    t.integer "sync_mode"
    t.integer "sync_interval"
    t.integer "sync_interval_unit"
    t.string "stream_name"
    t.string "workflow_id"
    t.datetime "discarded_at"
    t.string "cursor_field"
    t.string "current_cursor_field"
    t.string "cron_expression"
    t.string "name"
    t.index ["discarded_at"], name: "index_syncs_on_discarded_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "confirmation_code"
    t.datetime "confirmed_at"
    t.string "name"
    t.string "unique_id"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "status", default: 0
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unique_id"], name: "index_users_on_unique_id"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "visual_components", force: :cascade do |t|
    t.integer "component_type", null: false
    t.string "name"
    t.integer "workspace_id", null: false
    t.integer "data_app_id", null: false
    t.integer "model_id", null: false
    t.jsonb "properties"
    t.jsonb "feedback_config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workspace_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["role_id"], name: "index_workspace_users_on_role_id"
    t.index ["user_id", "workspace_id", "role_id"], name: "index_workspace_users_on_user_workspace_role", unique: true
    t.index ["user_id"], name: "index_workspace_users_on_user_id"
    t.index ["workspace_id"], name: "index_workspace_users_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "status"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.text "description"
    t.string "region"
    t.index ["organization_id"], name: "index_workspaces_on_organization_id"
  end

  add_foreign_key "workspace_users", "roles"
  add_foreign_key "workspace_users", "users"
  add_foreign_key "workspace_users", "workspaces", on_delete: :nullify
  add_foreign_key "workspaces", "organizations"
end
