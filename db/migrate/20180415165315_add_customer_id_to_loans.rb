class AddCustomerIdToLoans < ActiveRecord::Migration[5.1]
  def change
    add_reference :loans, :user, foreign_key: true
  end
end
