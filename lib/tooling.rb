# require "tooling/monkey_patch"
require "tooling/version"
require "tooling/client"
require_relative "tooling/response"
require "tooling/connection"

class Hash
  def underscore_keys!
    keys.each do |k|
      v = delete(k)
      new_key = k.to_s.gsub(/[A-Z]/, '_\0').downcase
      self[new_key] = v
      v.underscore_keys! if v.is_a?(Hash)
      v.each{|p| p.rubyify_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    end

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
