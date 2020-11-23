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

ActiveRecord::Schema.define(version: 2020_11_23_151425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cookbook_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "cookbook_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cookbook_id"], name: "index_cookbook_recipes_on_cookbook_id"
    t.index ["recipe_id"], name: "index_cookbook_recipes_on_recipe_id"
  end

  create_table "cookbooks", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cookbooks_on_user_id"
  end

  create_table "doses", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.float "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_doses_on_ingredient_id"
    t.index ["recipe_id"], name: "index_doses_on_recipe_id"
  end

  create_table "grocery_items", force: :cascade do |t|
    t.bigint "grocery_list_id", null: false
    t.string "total_quantity"
    t.bigint "ingredient_id", null: false
    t.boolean "bought"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grocery_list_id"], name: "index_grocery_items_on_grocery_list_id"
    t.index ["ingredient_id"], name: "index_grocery_items_on_ingredient_id"
  end

  create_table "grocery_lists", force: :cascade do |t|
    t.bigint "week_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["week_id"], name: "index_grocery_lists_on_week_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "list_of_restrictions", default: [], array: true
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "week_id", null: false
    t.bigint "recipe_id", null: false
    t.string "moment"
    t.date "day"
    t.integer "num_of_members"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_meals_on_recipe_id"
    t.index ["week_id"], name: "index_meals_on_week_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.boolean "status"
    t.string "difficulty"
    t.integer "cooking_time"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "num_of_members"
    t.text "address"
    t.text "list_of_restrictions", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_weeks_on_user_id"
  end

  add_foreign_key "cookbook_recipes", "cookbooks"
  add_foreign_key "cookbook_recipes", "recipes"
  add_foreign_key "cookbooks", "users"
  add_foreign_key "doses", "ingredients"
  add_foreign_key "doses", "recipes"
  add_foreign_key "grocery_items", "grocery_lists"
  add_foreign_key "grocery_items", "ingredients"
  add_foreign_key "grocery_lists", "weeks"
  add_foreign_key "meals", "recipes"
  add_foreign_key "meals", "weeks"
  add_foreign_key "recipes", "users"
  add_foreign_key "weeks", "users"
end
