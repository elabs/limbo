require "limbo/version"
require "limbo/rails_data"
require "limbo/client"

module Limbo

  class << self
    attr_accessor :uri, :key

    def configure
      yield self
    end

    def rails_post(hash)
      post RailsData.new(hash).transform
    end

    def post(hash)
      Client.post(hash)
    end
  end
end

