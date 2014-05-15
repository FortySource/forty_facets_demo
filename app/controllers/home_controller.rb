class HomeController < ApplicationController
  before_filter :import, if: ->() { Movie.count == 0 || params[:reimport]}

  class MovieSearch < FortyFacets::FacetSearch
    model 'Movie'
    text :title
    facet :genre, name: 'Genre'
    facet :year, name: 'Releaseyear', order: :year
    facet :studio, name: 'Studio', order: :name
  end

  def index
    @search = MovieSearch.new(params)
    @movies = @search.result.paginate(page: params[:page], per_page: 5)
  end

  def import
    Movie.import
  end

end
