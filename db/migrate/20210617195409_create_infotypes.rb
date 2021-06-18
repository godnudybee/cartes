class CreateInfotypes < ActiveRecord::Migration[6.1]
  def change
    create_table :infotypes do |t|
      t.string :json

      t.timestamps
    end
  end
end
