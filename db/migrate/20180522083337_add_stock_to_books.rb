class AddStockToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :stock, :integer
  end
end
