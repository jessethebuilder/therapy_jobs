# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130907012317) do

  create_table "categories", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.boolean  "management"
    t.text     "aliases"
    t.string   "categorization_type"
    t.integer  "categorization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", force: true do |t|
    t.integer  "category_id"
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "website"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.string   "phone2"
    t.string   "email"
    t.string   "email2"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fax"
  end

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "setting_id"
  end

  create_table "farm_address_addresses", force: true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "street"
    t.string   "street2"
    t.string   "street3"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "spammable",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  create_table "job_form_sources", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "category_id"
    t.integer  "client_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_forms", force: true do |t|
    t.text     "q_a_hash"
    t.integer  "job_form_source_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_locations", force: true do |t|
    t.integer "facility_id"
    t.integer "job_id"
    t.integer "contact_id"
  end

  create_table "job_search_criteria", force: true do |t|
    t.text     "order_on"
    t.text     "search_on"
    t.text     "recent_jobs"
    t.boolean  "include_management"
    t.integer  "user_id"
    t.boolean  "temporary",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "states"
    t.text     "categories"
  end

  create_table "jobs", force: true do |t|
    t.text     "description"
    t.text     "benefits"
    t.text     "requirements"
    t.text     "desirements"
    t.float    "required_experience"
    t.float    "desired_experience"
    t.datetime "start_date"
    t.integer  "duration"
    t.float    "pay_rate"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "zip_verified",        default: false
    t.text     "highlight"
    t.integer  "client_id"
    t.integer  "main_facility_id"
  end

  create_table "settings", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.text     "aliases"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "this_type"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.string   "phone2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
