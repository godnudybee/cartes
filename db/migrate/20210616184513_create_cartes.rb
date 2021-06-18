class CreateCartes < ActiveRecord::Migration[6.1]
  def change
    create_table :cartes do |t|
      t.string :card_id
      t.string :masked_pan
      t.decimal :card_balance
      t.string :card_holder
      t.string :card_pan
      t.string :cardcurrency
      t.decimal :cardbalance
      t.string :billing_name
      t.string :billing_address
      t.string :billing_city
      t.string :billing_country
      t.string :billing_zip_code
      t.string :billing_state
      t.string :card_currency
      t.string :status
      t.string :success
      t.string :zip_code
      t.string :cvv
      t.string :expiration
      t.integer :active

      t.timestamps
    end
  end
end
