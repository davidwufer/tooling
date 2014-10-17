module Tooling
  class Client
    # attr_reader :config
    attr_reader :connection

    # TODO: move these elsewhere
    attr_reader :session_id
    attr_reader :api_version
    # Currently unused
    attr_reader :instance

    # Tooling::Client.configure do |c|
    #   c.session_id = 'blahblah'
    # end

    def initialize(args = {})
      @internal_params = {}
      @api_version = args[:api_version] || 32.0
      @connection = args[:connection] || Connection.new

      session_id = args[:session_id]
      if session_id
        @internal_params[:session_id] = session_id
      else
        client_id = args[:client_id]
        client_secret = args[:client_secret]
        username = args[:username]
        password = args[:password]
        security_token = args[:security_token]
        if client_id && client_secret && username && password
          oauth_login = "https://login.salesforce.com/services/oauth2/token"
          result = connection.faraday.post do |req|
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

          # Uhhh, fix this
          require 'json'
          access_token = JSON.parse(result.body)["access_token"]

          @internal_params[:session_id] = access_token
          # puts result.body
        end
      end

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

    def request(params = {})
      puts @internal_params
      connection.request(params.merge(@internal_params))
    end


  end
end
