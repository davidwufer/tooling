# require "tooling/monkey_patch"
require "tooling/version"
require "tooling/client"
require "tooling/connection"

# TODO: Pull this into a separate method
class Hash
  # Stolen from http://wynnnetherland.com/journal/what-makes-a-good-api-wrapper
  # Converts all of the keys to strings, optionally formatting key name
  def rubyify_keys!
    keys.each{|k|
      v = delete(k)
      new_key = k.to_s.underscore
      self[new_key] = v
      v.rubyify_keys! if v.is_a?(Hash)
      v.each{|p| p.rubyify_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end
end


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
