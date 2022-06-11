# frozen_string_literal: true

##
# Lets the user search for movies
class MoviesController < ApplicationController
  def index
    @movies = Movie.where('title LIKE (?)', "%#{params[:query]}%").order(:created_at).page(params[:page])
  end
end
