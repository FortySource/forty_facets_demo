# frozen_string_literal: true

##
# Lets the user search for movies
class MoviesController < ApplicationController
  def index
    @movies = Movie.take(10)
  end
end
