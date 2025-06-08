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

ActiveRecord::Schema[8.0].define(version: 2025_06_08_143448) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "members", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.date "joined"
    t.date "left"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_members_on_player_id"
    t.index ["team_id"], name: "index_members_on_team_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "team_id", null: false
    t.integer "place"
    t.integer "prize"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_participants_on_team_id"
    t.index ["tournament_id", "place"], name: "index_participants_on_tournament_id_and_place", unique: true, where: "place IS NOT NULL"
    t.index ["tournament_id"], name: "index_participants_on_tournament_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "nickname"
    t.string "realname"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nickname"], name: "index_players_on_nickname", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "worldRanking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["name"], name: "index_teams_on_name", unique: true
    t.index ["worldRanking"], name: "index_teams_on_worldRanking", unique: true
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.integer "prizepool"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tournaments_on_name", unique: true
  end

  add_foreign_key "members", "players"
  add_foreign_key "members", "teams"
  add_foreign_key "participants", "teams"
  add_foreign_key "participants", "tournaments"
end
