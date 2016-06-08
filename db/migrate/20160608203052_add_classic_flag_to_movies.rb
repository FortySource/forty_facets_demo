class AddClassicFlagToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :is_classic, :boolean, null: false, default: false
  end
end
