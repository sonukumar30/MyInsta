class AddUseridToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :user_id, :string
  end
end
