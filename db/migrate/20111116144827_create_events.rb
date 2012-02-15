class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :datetime
      t.datetime :datetime_end
      t.text :info
      t.string :location
      t.integer :user_id

      t.timestamps
    end
  end
end
