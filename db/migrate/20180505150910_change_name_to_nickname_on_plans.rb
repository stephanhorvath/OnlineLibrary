class ChangeNameToNicknameOnPlans < ActiveRecord::Migration[5.1]
  def change
    rename_column :plans, :name, :nickname
  end
end
