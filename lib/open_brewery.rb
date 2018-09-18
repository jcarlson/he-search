class OpenBrewery
  API = 'https://api.openbrewerydb.org'
  SEARCH = '/breweries/search'

  class ApiError < StandardError; end

  def initialize
    @connection = Faraday.new(url: API)
  end

  def search(query)
    response = @connection.get do |request|
      request.url '/breweries/search', query: query
    end

    response.success? and JSON.parse(response.body) or raise ApiError
  end
end
