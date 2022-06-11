# frozen_string_literal: true

##
# Lets the user search for movies
class MoviesController < ApplicationController
  def index
    @movies = Movie.where('title LIKE (?)', "%#{params[:query]}%")
  end
end
