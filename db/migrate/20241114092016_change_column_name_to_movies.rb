class ChangeColumnNameToMovies < ActiveRecord::Migration[7.1]
  change_table :movies do |t|
    t.rename :name, :title
  end
end
