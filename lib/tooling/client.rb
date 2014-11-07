require 'json'
require 'forwardable'

module Tooling
  class Client
    extend Forwardable
    def_delegators :connection, :describe, :describe_deep, :query

    # attr_reader :config
    attr_reader :connection

    # TODO: move these elsewhere
    attr_reader :session_id
    attr_reader :api_version

    # Tooling::Client.configure do |c|
    #   c.session_id = 'blahblah'
    # end

    # TODO: Refactor
    def initialize(args = {})
      @internal_params = {}
      @api_version = args[:api_version] || 32.0

      session_id = args[:session_id]
      if session_id
        access_token = session_id
        instance_url = nil
      else
        client_id = args[:client_id]
        client_secret = args[:client_secret]
        username = args[:username]
        password = args[:password]
        security_token = args[:security_token]
        if client_id && client_secret && username && password
          oauth_login = "https://login.salesforce.com/services/oauth2/token"
          result = Faraday.new.post do |req|
            req.url oauth_login,
            # req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
            req.body = {
              grant_type: "password",
              client_id: client_id,
              client_secret: client_secret,
              username: username,
              password: password + security_token
            }
          end

          # puts JSON.pretty_generate(JSON.parse(result.body))

          json_hash = JSON.parse(result.body)
          instance_url = json_hash["instance_url"]
          access_token = json_hash["access_token"]
        end
      end

      @connection = args[:connection] || Connection.new(api_version: api_version, instance_url: instance_url, access_token: access_token)

      # Forget about configs for now
      # @config = args[:config] || configuration
    end

    # def configure
    #   yield(&config)
    # end
    #
    # def configuration
    #   @configuration ||= Configuration.new
    # end

    # def describe(sobject)
    #   connection.describe(sobject)
    # end
  end
end
