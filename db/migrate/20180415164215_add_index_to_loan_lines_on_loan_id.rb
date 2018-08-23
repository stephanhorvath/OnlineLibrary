class AddIndexToLoanLinesOnLoanId < ActiveRecord::Migration[5.1]
  def change
    add_index :loan_lines, :loan_id
  end
end
