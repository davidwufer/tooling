require "tooling/version"
require "tooling/client"
require "tooling/connection"

module Tooling
  def self.configure(&block)
    reset!
    client.configure(&block)
  end

  def self.client
    @client ||= Client.new
  end

  def self.reset!
    @client = nil
  end
end
