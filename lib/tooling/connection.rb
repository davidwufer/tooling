require 'faraday'
require 'faraday_middleware'

module Tooling
  class Connection
    attr_reader :faraday

    def initialize(args = {})
      @faraday = args[:faraday] || Faraday.new
      @access_token = args[:access_token]
      @base_tooling_url = create_base_tooling_url(args)
    end

    # Pretty cool stuff
    # def sobjects
    #   body = request('sobjects')
    # end

    def query(query_string)
      extension_url = ['query']
      request(extension_url, 'q' => query_string)
    end

    def get(sobject, id)
      extension_url = ['sobjects', sobject, id].join('/')
      request(extension_url)
    end

    def describe(sobject)
      extension_url = ['sobjects', sobject].join('/')
      request(extension_url)
    end

    def describe_deep(sobject)
      extension_url = ['sobjects', sobject, 'describe'].join('/')
      request(extension_url)
    end

    private
      def request(extension_url, params = {})
        full_url = [@base_tooling_url, extension_url].join('/')

        response = faraday.get do |req|
          req.url full_url
          req.headers['Authorization'] = "Bearer #{@access_token}"
          req.params.merge!(params)
        end

        return Tooling::Response.new(response)
      end

      def create_base_tooling_url(args)
        [
          args[:instance_url] || "https://na1.salesforce.com",
          'services',
          'data',
          "v#{args[:api_version]}",
          'tooling'
        ].join('/')
      end
  end
end
