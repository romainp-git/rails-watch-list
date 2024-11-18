class AddTableGenres < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :genre

    create_table :genres, if_not_exists: true do |t|
      t.string :name
      t.timestamps
    end
  end
end
