class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change    
    add_column :users, :document_url, :string
    add_column :users, :piece_url, :string
  end
end
