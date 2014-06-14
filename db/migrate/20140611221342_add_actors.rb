class AddActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.timestamps
    end

    create_table :actors_movies do |t|
      t.integer :actor_id
      t.integer :movie_id
      t.timestamps
    end

    create_table :writers do |t|
      t.string :name
      t.timestamps
    end

    create_table :movies_writers do |t|
      t.integer :writer_id
      t.integer :movie_id
      t.timestamps
    end
  end
end
