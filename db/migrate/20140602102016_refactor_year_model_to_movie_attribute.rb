class RefactorYearModelToMovieAttribute < ActiveRecord::Migration
  def change
    add_column :movies, :year, :integer
    remove_column :movies, :year_id
    drop_table :years
  end
end
