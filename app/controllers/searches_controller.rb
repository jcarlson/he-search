class SearchesController < ApplicationController
  def index
    @search = Search.new
    @trending = Search.trending.limit(10)
  end

  def create
    @search = Search.create search_params
    redirect_to search_index_path
  end

  private

  def search_params
    params.require(:search).permit(:term)
  end
end
