class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.boolean :disable_posts
      t.integer :user_id

      t.timestamps
    end
  end
end
