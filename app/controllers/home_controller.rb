class HomeController < ApplicationController
  before_filter :import, if: ->() { Movie.count == 0 || params[:reimport]}

  class MovieSearch < FortyFacets::FacetSearch
    model 'Movie'

    text :title
    range :price
    facet :genre, name: 'Genre'
    facet :year, name: 'Releaseyear', order: :year
    facet :studio, name: 'Studio', order: :name

    orders 'Title' => :title,
           'price, cheap first' => "price asc",
           'price, expensive first' => {price: :desc, title: :desc}


  end

  def index
    @search = MovieSearch.new(params)
    @movies = @search.result.paginate(page: params[:page], per_page: 5)
  end

  def import
    Movie.import
  end

end
