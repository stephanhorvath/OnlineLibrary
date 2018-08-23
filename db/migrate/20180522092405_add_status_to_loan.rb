class AddStatusToLoan < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :status, :string
  end
end
