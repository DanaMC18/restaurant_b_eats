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

ActiveRecord::Schema.define(version: 20190512004754) do

  create_table "cuisines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "inspection_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "inspections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "inspection_type_id",           null: false
    t.integer  "restaurant_id",                null: false
    t.integer  "score"
    t.string   "grade",              limit: 1
    t.date     "grade_date"
    t.date     "inspection_date",              null: false
    t.date     "record_date",                  null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["grade"], name: "index_inspections_on_grade", using: :btree
    t.index ["grade_date"], name: "index_inspections_on_grade_date", using: :btree
    t.index ["inspection_type_id"], name: "index_inspections_on_inspection_type_id", using: :btree
    t.index ["restaurant_id"], name: "index_inspections_on_restaurant_id", using: :btree
    t.index ["score"], name: "index_inspections_on_score", using: :btree
  end

  create_table "inspections_violations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "inspection_id", null: false
    t.integer  "violations_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["inspection_id"], name: "index_inspections_violations_on_inspection_id", using: :btree
    t.index ["violations_id"], name: "index_inspections_violations_on_violations_id", using: :btree
  end

  create_table "restaurants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "camis",           null: false
    t.string   "dba",             null: false
    t.integer  "cuisine_id",      null: false
    t.string   "building_number", null: false
    t.string   "street",          null: false
    t.string   "boro",            null: false
    t.integer  "zipcode",         null: false
    t.integer  "phone_number",    null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["camis"], name: "index_restaurants_on_camis", using: :btree
    t.index ["cuisine_id"], name: "index_restaurants_on_cuisine_id", using: :btree
    t.index ["dba"], name: "index_restaurants_on_dba", using: :btree
  end

  create_table "violations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code",        limit: 3,                 null: false
    t.string   "description",                           null: false
    t.boolean  "is_critical",           default: false, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["code"], name: "index_violations_on_code", using: :btree
    t.index ["is_critical"], name: "index_violations_on_is_critical", using: :btree
  end

end
