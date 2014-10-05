require 'faraday'
require 'faraday_middleware'

module Tooling
  class Connection
    attr_reader :faraday

    def initialize(args = {})
      @faraday = args[:faraday] || Faraday.new
    end

    def request(url, params = {})
      faraday.get(url, params)
    end
  end
end
