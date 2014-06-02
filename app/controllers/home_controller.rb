class HomeController < ApplicationController
  before_filter :import, if: ->() { Movie.count == 0 || params[:reimport]}

  class MovieSearch < FortyFacets::FacetSearch
    model 'Movie'

    text :title, name: 'Title'
    range :price, name: 'Price'
    facet :genre, name: 'Genre'
    facet :year, order: Proc.new { |year| -year }
    facet :studio, name: 'Studio', order: :name

    orders 'Title' => :title,
           'price, cheap first' => "price asc",
           'price, expensive first' => {price: :desc, title: :desc}
  end

  def index
    @search = MovieSearch.new(params)
    @movies = @search.result.paginate(page: params[:page], per_page: 9)
  end

  def import
    Movie.import
  end

end
