require 'errors'

module Tooling
  module Authorization
    class BasicAuthPolicy
      def initialize(options = {}); end

      def authorize
        raise Tooling::ConfigurationError, "Tooling has not been configured to make authorized requests."
      end
    end

    class SessionIdAuthPolicy < BasicAuthPolicy
    end

    class OAuthPolicy < BasicAuthPolicy
    end
  end
end
