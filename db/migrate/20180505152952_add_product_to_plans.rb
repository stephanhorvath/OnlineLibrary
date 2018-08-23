class AddProductToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :product, :string
  end
end
