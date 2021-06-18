class CreateLoadings < ActiveRecord::Migration[6.1]
  def change
    create_table :loadings do |t|
      t.decimal :taux
      t.decimal :loaded_amount
      t.decimal :remaining_amount

      t.timestamps
    end
  end
end
