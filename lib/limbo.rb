require "limbo/version"
require "limbo/rails/data"
require "limbo/client"

module Limbo

  class << self
    attr_accessor :uri, :key

    def configure
      yield self
    end

    def rails_post(hash)
      transformed_hash = Rails::Data.new(hash).transform
      post(transformed_hash)
    end

    def post(hash)
      Client.post(hash)
    end
  end
end

