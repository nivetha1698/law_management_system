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

ActiveRecord::Schema[7.2].define(version: 2025_05_23_113522) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.string "auditable_type"
    t.bigint "auditable_id"
    t.bigint "user_id"
    t.string "action"
    t.text "changes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audit_logs_on_auditable"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "case_lawyers", id: false, force: :cascade do |t|
    t.bigint "case_id", null: false
    t.bigint "lawyer_id", null: false
    t.index ["case_id", "lawyer_id"], name: "index_case_lawyers_on_case_id_and_lawyer_id", unique: true
    t.index ["case_id"], name: "index_case_lawyers_on_case_id"
    t.index ["lawyer_id"], name: "index_case_lawyers_on_lawyer_id"
  end

  create_table "case_tags", force: :cascade do |t|
    t.bigint "case_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_tags_on_case_id"
    t.index ["tag_id"], name: "index_case_tags_on_tag_id"
  end

  create_table "cases", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "status", default: "open"
    t.string "priority"
    t.string "workflow_status", default: "intake"
    t.bigint "client_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_cases_on_category_id"
    t.index ["client_id"], name: "index_cases_on_client_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checklist_items", force: :cascade do |t|
    t.bigint "checklist_id"
    t.string "content"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checklist_id"], name: "index_checklist_items_on_checklist_id"
  end

  create_table "checklists", force: :cascade do |t|
    t.string "title"
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_checklists_on_case_id"
  end

  create_table "document_versions", force: :cascade do |t|
    t.bigint "document_id"
    t.integer "version_number"
    t.text "file_path"
    t.bigint "uploaded_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_versions_on_document_id"
    t.index ["uploaded_by_id"], name: "index_document_versions_on_uploaded_by_id"
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "uploaded_by_id"
    t.string "title"
    t.text "file_path", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_documents_on_case_id"
    t.index ["uploaded_by_id"], name: "index_documents_on_uploaded_by_id"
  end

  create_table "hearings", force: :cascade do |t|
    t.bigint "case_id"
    t.datetime "date", null: false
    t.string "location"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_hearings_on_case_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "issued_to_id"
    t.decimal "amount", precision: 10, scale: 2
    t.string "status", default: "unpaid"
    t.date "issued_at"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_invoices_on_case_id"
    t.index ["issued_to_id"], name: "index_invoices_on_issued_to_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "lawyer_id"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_notes_on_case_id"
    t.index ["lawyer_id"], name: "index_notes_on_lawyer_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.text "message", null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.datetime "remind_at"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "case_id"
    t.string "title"
    t.text "description"
    t.date "due_date"
    t.string "status", default: "pending"
    t.bigint "assigned_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to"], name: "index_tasks_on_assigned_to"
    t.index ["case_id"], name: "index_tasks_on_case_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "case_id"
    t.text "description"
    t.decimal "hours", precision: 6, scale: 2
    t.decimal "rate", precision: 8, scale: 2
    t.boolean "billable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_time_entries_on_case_id"
    t.index ["user_id"], name: "index_time_entries_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.bigint "team_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "audit_logs", "users"
  add_foreign_key "case_lawyers", "cases"
  add_foreign_key "case_lawyers", "users", column: "lawyer_id"
  add_foreign_key "case_tags", "cases"
  add_foreign_key "case_tags", "tags"
  add_foreign_key "cases", "categories"
  add_foreign_key "cases", "users", column: "client_id"
  add_foreign_key "checklist_items", "checklists"
  add_foreign_key "checklists", "cases"
  add_foreign_key "document_versions", "documents"
  add_foreign_key "document_versions", "users", column: "uploaded_by_id"
  add_foreign_key "documents", "cases"
  add_foreign_key "documents", "users", column: "uploaded_by_id"
  add_foreign_key "hearings", "cases"
  add_foreign_key "invoices", "cases"
  add_foreign_key "invoices", "users", column: "issued_to_id"
  add_foreign_key "notes", "cases"
  add_foreign_key "notes", "users", column: "lawyer_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "reminders", "users"
  add_foreign_key "tasks", "cases"
  add_foreign_key "tasks", "users", column: "assigned_to"
  add_foreign_key "time_entries", "cases"
  add_foreign_key "time_entries", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "teams"
end
