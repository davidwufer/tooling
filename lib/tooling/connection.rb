require 'faraday'
require 'faraday_middleware'

module Tooling
  class Connection
    attr_reader :faraday

    BASE_URL = "https://na17.salesforce.com/services/data/v32.0/sobjects"

    def initialize(args = {})
      @faraday = args[:faraday] || Faraday.new
    end

    def request(params = {})
      sobject = params.delete('sobject')

      url = [BASE_URL, sobject, 'describe'].join("/")

      faraday.get(url, params)
    end
  end
end
