class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.string :genre
      t.string :publisher
      t.integer :supplierID
      t.string :type

      t.timestamps
    end
  end
end
