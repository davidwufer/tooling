require 'spec_helper'

module Tooling
  describe Response do
    let(:response) { Tooling::Response.new(nil) }

    it "responds to status" do
      expect(response).to respond_to(:status)
    end

    it "responds to body" do
      expect(response).to respond_to(:body)
    end

    it "responds to success?" do
      expect(response).to respond_to(:success?)
    end
  end
end
