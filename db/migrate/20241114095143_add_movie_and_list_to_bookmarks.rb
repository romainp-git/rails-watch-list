class AddMovieAndListToBookmarks < ActiveRecord::Migration[7.1]
  change_table :bookmarks do |t|
    t.remove :lists_id, :movies_id
  end

  def change
    add_reference :bookmarks, :movie, null: false, foreign_key: true
    add_reference :bookmarks, :list, null: false, foreign_key: true
  end
end
