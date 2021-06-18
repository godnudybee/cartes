class CreateHistoriqueechecs < ActiveRecord::Migration[6.1]
  def change
    create_table :historiqueechecs do |t|
      t.string :desc_operation
      t.string :info_json
      t.integer :pmtpg_id

      t.timestamps
    end
  end
end
