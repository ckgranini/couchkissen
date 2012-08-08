class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :title
      t.integer :poll_id

      t.timestamps
    end
  end
end
