class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :town
      t.string :post_code
      t.string :tel_no
      t.string :email
      t.string :password_digest
      t.string :type

      t.timestamps
    end
  end
end
