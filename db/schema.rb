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

ActiveRecord::Schema.define(version: 2019_01_02_164849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "notes"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_attempts_on_task_id"
  end

  create_table "phases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "kind"
    t.text "notes"
    t.bigint "task_id"
    t.bigint "attempt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_phases_on_attempt_id"
    t.index ["task_id"], name: "index_phases_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_periods", force: :cascade do |t|
    t.datetime "starts"
    t.datetime "finishes"
    t.string "name"
    t.text "description"
    t.bigint "task_id"
    t.bigint "attempt_id"
    t.bigint "phase_id"
    t.bigint "try_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_time_periods_on_attempt_id"
    t.index ["phase_id"], name: "index_time_periods_on_phase_id"
    t.index ["task_id"], name: "index_time_periods_on_task_id"
    t.index ["try_id"], name: "index_time_periods_on_try_id"
  end

  create_table "tries", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "notes"
    t.bigint "task_id"
    t.bigint "attempt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_tries_on_attempt_id"
    t.index ["task_id"], name: "index_tries_on_task_id"
  end

end
