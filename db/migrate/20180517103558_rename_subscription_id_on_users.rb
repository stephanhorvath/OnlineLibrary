class RenameSubscriptionIdOnUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :subsription_id, :subscription_id
  end
end
