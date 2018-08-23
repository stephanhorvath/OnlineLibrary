class AddIndexOnBookIdToLoanLines < ActiveRecord::Migration[5.1]
  def change
    add_index :loan_lines, :book_id
  end
end
