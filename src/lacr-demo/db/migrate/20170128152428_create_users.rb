#By Marcel Zak
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :nick_name, null: false, index: true
      t.string :email_address, null: false, index: true
      t.string :hashed_password
      t.string :salt
      t.datetime :last_login
      t.datetime :last_unsuccessful_login
      t.integer :unsuccessful_logins, default: 0
      t.integer :number_of_comments, default: 0
      t.integer :rights, default: 0
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
