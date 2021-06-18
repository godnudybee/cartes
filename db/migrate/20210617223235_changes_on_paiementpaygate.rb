class ChangesOnPaiementpaygate < ActiveRecord::Migration[6.1]
  def change
    change_table :paiementpaygates do |t|
      t.rename :tx_e_cart, :tx_ec
    end

    add_column :paiementpaygates, :type_id, :integer
  end
end
