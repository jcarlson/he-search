class SearchesController < ApplicationController
  def index
    @search = Search.new
    @trending = trending
  end

  def create
    search = Search.create search_params
    redirect_to search_path(search.term)
  end

  def show
    @search = Search.trending.find_by(term: params[:term])
  end

  private

  def trending
    scope = Search.trending

    if params[:sort]
      _, order, field = params[:sort].rpartition('-')
      scope.reorder!(field)
      scope.reverse_order! if order == '-'
    end

    scope
  end

  def search_params
    params.require(:search).permit(:term)
  end

  def sort_order

  end
end
