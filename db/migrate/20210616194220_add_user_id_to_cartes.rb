class AddUserIdToCartes < ActiveRecord::Migration[6.1]
  def change
    add_column :cartes, :user_id, :integer
  end
end
