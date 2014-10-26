require 'faraday'
require 'faraday_middleware'

module Tooling
  class Connection
    attr_reader :faraday

    BASE_URL = "https://na17.salesforce.com/services/data/v32.0/tooling"

    def initialize(args = {})
      @faraday = args[:faraday] || Faraday.new
      @access_token = args[:access_token]
      @base_tooling_url = create_base_tooling_url(args)
    end

    def describe(sobject)
      extension_url = ['sobjects', sobject].join('/')
      request(extension_url)
    end

    def describe_deep(sobject)
      extension_url = ['sobjects', sobject, 'describe'].join('/')
      request(extension_url)
    end

    def request(extension_url)
      full_url = [@base_tooling_url, extension_url].join('/')

      puts full_url
      faraday.get do |req|
        req.url full_url
        req.headers['Authorization'] = "Bearer #{@access_token}"
      end
    end

    private
      def create_base_tooling_url(args)
        [
          args[:instance_url] || "https://na1.salesforce.com",
          'services', 'data', "v#{args[:api_version]}", 'tooling'
        ].join('/')
      end
  end
end
