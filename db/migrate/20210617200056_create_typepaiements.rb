class CreateTypepaiements < ActiveRecord::Migration[6.1]
  def change
    create_table :typepaiements do |t|
      t.string :libelle
      t.integer :info_id

      t.timestamps
    end
  end
end
