class CreateDepots < ActiveRecord::Migration[6.1]
  def change
    create_table :depots do |t|
      t.integer :pmt_pg_id
      t.decimal :montant_usd
      t.string :card_id

      t.timestamps
    end
  end
end
