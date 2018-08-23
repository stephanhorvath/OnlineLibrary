class AddSubscriptionIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subsription_id, :string
  end
end
