# frozen_string_literal: true

##
# Lets the user search for movies
class MoviesController < ApplicationController
  class MovieSearch < FortyFacets::FacetSearch
    model 'Movie'

    text  :title, name: 'Title'
  end

  def index
    @search = MovieSearch.new(params)
    @movies = @search.result.page(params[:page])
  end
end
