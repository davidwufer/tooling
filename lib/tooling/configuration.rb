module Tooling
  class Configuration
    # A really simple configuration for now
    attr_reader :session_id

    def initialize(args = {})
      @session_id = args[:session_id]
    end
  end
end
