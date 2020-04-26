class AddUserIdToCredentials < ActiveRecord::Migration[6.0]
  def change
    add_column :credentials, :user_id, :integer

    add_index :credentials, :user_id
  end
end
