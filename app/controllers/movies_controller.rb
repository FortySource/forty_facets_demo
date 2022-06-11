# frozen_string_literal: true

##
# Lets the user search for movies
class MoviesController < ApplicationController
  class MovieSearch < FortyFacets::FacetSearch
    model 'Movie'

    text  :title, name: 'Title'
    facet :year
    facet :actors
    facet :writers

    orders 'Title' => :title,
           'price, cheap first' => 'price asc',
           'price, expensive first' => { price: :desc, title: :desc }
  end

  def index
    @search = MovieSearch.new(params)
    @movies = @search.result.distinct.page(params[:page])
  end
end
