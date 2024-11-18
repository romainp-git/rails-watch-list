class AddColumnsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :vote_average, :decimal
    add_column :movies, :genre, :string
  end
end
