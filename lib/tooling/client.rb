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
      raise ArgumentError.new("session_id not provided") unless args[:session_id]
      @session_id = args[:session_id]

      @api_version = args[:api_version] || 32.0

      # Forget about configs for now
      # @config = args[:config] || configuration
      @connection = args[:connection] || Connection.new
    end

    # def configure
    #   yield(&config)
    # end
    #
    # def configuration
    #   @configuration ||= Configuration.new
    # end

    def request
      connection.request
    end


  end
end
