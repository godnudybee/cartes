class CreatePaiementpaygates < ActiveRecord::Migration[6.1]
  def change
    create_table :paiementpaygates do |t|
      t.string :tx_reference
      t.string :payment_reference
      t.string :phone
      t.timestamp :date_paiement
      t.integer :pmt_done
      t.integer :fxk_done
      t.decimal :tx_pg
      t.decimal :tx_fx
      t.decimal :tx_e_cart
      t.integer :info_type_pmt_id

      t.timestamps
    end
  end
end
