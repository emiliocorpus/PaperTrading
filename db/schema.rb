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

ActiveRecord::Schema.define(version: 20151214071605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolios", force: :cascade do |t|
    t.string   "symbol"
    t.string   "company_name"
    t.integer  "quantity"
    t.decimal  "average_price"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "portfolios", ["symbol"], name: "index_portfolios_on_symbol", unique: true, using: :btree
  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "picture"
    t.text     "content_html"
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true, using: :btree
  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.string   "company_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "stocks", ["symbol"], name: "index_stocks_on_symbol", using: :btree

  create_table "trades", force: :cascade do |t|
    t.string   "symbol_traded"
    t.integer  "shares_traded"
    t.decimal  "total_amount_traded"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "trades", ["symbol_traded"], name: "index_trades_on_symbol_traded", using: :btree
  add_index "trades", ["user_id"], name: "index_trades_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "remember_digest"
    t.boolean  "admin",                    default: false
    t.string   "activation_digest"
    t.boolean  "activated",                default: false
    t.datetime "activated_at"
    t.datetime "activation_email_sent_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "watchlists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "watchlists", ["name"], name: "index_watchlists_on_name", using: :btree
  add_index "watchlists", ["user_id"], name: "index_watchlists_on_user_id", using: :btree

  create_table "watchlists_stocks", force: :cascade do |t|
    t.integer  "watchlist_id"
    t.integer  "stock_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "watchlists_stocks", ["stock_id"], name: "index_watchlists_stocks_on_stock_id", using: :btree
  add_index "watchlists_stocks", ["watchlist_id"], name: "index_watchlists_stocks_on_watchlist_id", using: :btree

  add_foreign_key "portfolios", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "trades", "users"
  add_foreign_key "watchlists", "users"
  add_foreign_key "watchlists_stocks", "stocks"
  add_foreign_key "watchlists_stocks", "watchlists"
end
