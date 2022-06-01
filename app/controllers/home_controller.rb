# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :assert_movies, only: [:index]

  def index
    @search = MovieSearch.new(params)
    @movies = @search.result.paginate(page: params[:page])
  end

  private

  def assert_movies
    flash.now[:danger] = ERR_NO_MOVIES unless Movie.any?
  end

  ERR_NO_MOVIES = ''"
      There are no movies.
      Please run `rake movies:import` in your terminal.
    "''
end
