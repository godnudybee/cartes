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

ActiveRecord::Schema.define(version: 2021_06_22_230304) do

  create_table "add_active_to_cartes", force: :cascade do |t|
    t.integer "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "card_states", force: :cascade do |t|
    t.integer "carte_id"
    t.decimal "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cartes", force: :cascade do |t|
    t.string "card_id"
    t.string "masked_pan"
    t.decimal "card_balance"
    t.string "card_holder"
    t.string "card_pan"
    t.string "cardcurrency"
    t.decimal "cardbalance"
    t.string "billing_name"
    t.string "billing_address"
    t.string "billing_city"
    t.string "billing_country"
    t.string "billing_zip_code"
    t.string "billing_state"
    t.string "card_currency"
    t.string "status"
    t.string "success"
    t.string "zip_code"
    t.string "cvv"
    t.string "expiration"
    t.integer "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "depots", force: :cascade do |t|
    t.integer "pmt_pg_id"
    t.decimal "montant_usd"
    t.string "card_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "historiqueechecs", force: :cascade do |t|
    t.string "desc_operation"
    t.string "info_json"
    t.integer "pmtpg_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "infotypes", force: :cascade do |t|
    t.string "json"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loadings", force: :cascade do |t|
    t.decimal "taux"
    t.decimal "loaded_amount"
    t.decimal "remaining_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "newcards", force: :cascade do |t|
    t.integer "pmt_pg_id"
    t.string "cardholder"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "otps", force: :cascade do |t|
    t.string "phone"
    t.integer "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "paiementpaygates", force: :cascade do |t|
    t.string "tx_reference"
    t.string "payment_reference"
    t.string "phone"
    t.datetime "date_paiement"
    t.integer "pmt_done"
    t.integer "fxk_done"
    t.decimal "tx_pg"
    t.decimal "tx_fx"
    t.decimal "tx_ec"
    t.integer "info_type_pmt_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "type_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transactionId"
    t.integer "carte_id"
    t.decimal "transactionAmount"
    t.integer "fee"
    t.string "productName"
    t.string "providerResponseCode"
    t.string "providerResponseMessage"
    t.string "providerReference"
    t.string "transactionReference"
    t.string "uniqueReferenceDetails"
    t.integer "status"
    t.decimal "productId"
    t.string "uniqueReference"
    t.string "paymentReference"
    t.string "paymentType"
    t.string "paymentResponseCoe"
    t.string "paymentResponseMessage"
    t.integer "amountConfirmed"
    t.integer "currencyId"
    t.string "narration"
    t.string "indicator"
    t.string "dateCreated"
    t.string "statusName"
    t.string "description"
    t.string "currency"
    t.string "merchantName"
    t.string "transactionDescription"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "typepaiements", force: :cascade do |t|
    t.string "libelle"
    t.integer "info_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "phone"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "email"
    t.string "document_url"
    t.string "photo_url"
  end

end
