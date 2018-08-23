class AddBookLimitToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :book_limit, :integer
  end
end
