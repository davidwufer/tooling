module Tooling
  class Client
    attr_reader :config, :connection

    def initialize(args = {})
      @config = args[:config] || configuration
      @connection = args[:connection] || connection
    end

    def configure

    end

    def configuration
      @configuration ||= Configuration.new
    end

    def connection
    end

    def request

    end
  end
end
