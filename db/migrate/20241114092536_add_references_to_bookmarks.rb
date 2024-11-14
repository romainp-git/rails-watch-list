class AddReferencesToBookmarks < ActiveRecord::Migration[7.1]
  change_table :bookmarks do |t|
    t.remove :list_id, :movie_id
  end

  def change
    add_reference :bookmarks, :movies, foreign_key: true
    add_reference :bookmarks, :lists, foreign_key: true
  end
end
