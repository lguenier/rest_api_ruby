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

ActiveRecord::Schema.define(version: 2020_04_27_135008) do

  create_table "inventories", force: :cascade do |t|
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_inventories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "product"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products_reservations", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "reservation_id", null: false
    t.integer "inventory_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_id"], name: "index_products_reservations_on_inventory_id"
    t.index ["product_id"], name: "index_products_reservations_on_product_id"
    t.index ["reservation_id"], name: "index_products_reservations_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "inventories", "products"
  add_foreign_key "products_reservations", "inventories"
  add_foreign_key "products_reservations", "products"
  add_foreign_key "products_reservations", "reservations"
end
