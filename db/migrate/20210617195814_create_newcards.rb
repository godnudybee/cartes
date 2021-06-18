class CreateNewcards < ActiveRecord::Migration[6.1]
  def change
    create_table :newcards do |t|
      t.integer :pmt_pg_id
      t.string :cardholder
      t.integer :user_id

      t.timestamps
    end
  end
end
