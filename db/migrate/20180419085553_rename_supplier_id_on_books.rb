class RenameSupplierIdOnBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :supplierID, :supplier_id
  end
end
