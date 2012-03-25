class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :plot
      t.string :poster_id
      t.string :trailer_url
      t.string :tmdb_url
      t.string :tmdb_id
      t.string :imdb_id
      t.integer :user_id

      t.timestamps
    end
  end
end
