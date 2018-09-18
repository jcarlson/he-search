class SearchesController < ApplicationController
  def index
    @search = Search.new
    @trending = Search.trending.limit(10)
  end
end
