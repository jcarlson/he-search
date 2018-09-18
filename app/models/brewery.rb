require 'open_brewery'

class Brewery
  include ActiveModel::Model

  attr_accessor :id,
                :name,
                :brewery_type,
                :street,
                :city,
                :state,
                :postal_code,
                :country,
                :longitude,
                :latitude,
                :phone,
                :website_url,
                :updated_at

  class << self
    def search(query)
      api = OpenBrewery.new
      results = api.search(query)
      results.map { |attributes| new(attributes) }
    rescue OpenBrewery::ApiError
      nil
    end
  end

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(hash)
    hash.each { |key, value| send("#{key}=", value) }
  end

  alias_method :attributes, :instance_values
end
