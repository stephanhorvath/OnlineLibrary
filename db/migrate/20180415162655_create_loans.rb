class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.timestamp :begin_date
      t.timestamp :end_date
      t.boolean :returned

      t.timestamps
    end
  end
end
