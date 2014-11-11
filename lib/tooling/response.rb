module Tooling
  class Response
    def initialize(response)
      @response = response
    end

    # TODO: maybe use delegators
    def status
      @response.status
    end

    def success?
      @response.success?
    end

    def body
      JSON.parse(@response.body).rubyify_keys!
    end

  end
end
