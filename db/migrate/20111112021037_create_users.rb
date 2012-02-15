class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :auth_token
      t.string :password_digest
      t.date :b_date
      t.string :phone_home
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
