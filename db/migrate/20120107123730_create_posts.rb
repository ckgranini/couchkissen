class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :postable_id
      t.string :postable_type
      t.integer :user_id

      t.timestamps
    end
  end
end
