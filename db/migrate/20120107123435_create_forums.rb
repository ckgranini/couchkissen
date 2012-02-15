class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.text :info
      t.integer :user_id

      t.timestamps
    end
  end
end
