# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :studios do |t|
      t.string :name
      t.timestamps
    end

    create_table :genres do |t|
      t.string :name
      t.timestamps
    end

    create_table :movies do |t|
      t.string :title
      t.references :studio
      t.integer :year
      t.references :genre
      t.float :price
      t.boolean :is_classic

      t.timestamps
    end

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
