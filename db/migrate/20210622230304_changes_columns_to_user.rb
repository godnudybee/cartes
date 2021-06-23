class ChangesColumnsToUser < ActiveRecord::Migration[6.1]
  def change    
    change_table :users do |t|
      t.rename :piece_url, :photo_url
    end
  end
end
