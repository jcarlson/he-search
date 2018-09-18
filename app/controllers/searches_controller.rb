class SearchesController < ApplicationController
  def index
    @search = Search.new
    @trending = Search.trending.limit(10)
  end

  def create
    search = Search.create search_params
    redirect_to search_path(search.term)
  end

  def show
    @search = Search.trending.find_by(term: params[:term])
  end

  private

  def search_params
    params.require(:search).permit(:term)
  end
end
