class CreateLoanLines < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_lines do |t|
      t.integer :loan_id
      t.integer :book_id

      t.timestamps
    end
  end
end
