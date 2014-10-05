module Tooling
  # Base class for all errors
  ToolingBaseError = Class.new(StandardError)

  # Used when the client has not been configured properly
  ConfigurationError = Class.new(ToolingBaseError)
end
