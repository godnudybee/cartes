class CreateCardStates < ActiveRecord::Migration[6.1]
  def change
    create_table :card_states do |t|
      t.integer :carte_id
      t.decimal :status

      t.timestamps
    end
  end
end
