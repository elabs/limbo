require "limbo/version"
require "limbo/rails/data"
require "limbo/client"

module Limbo

  class << self
    attr_accessor :uri, :key, :environment, :service, :service_name

    def configure
      yield self
      check_required_keys
    end

    def rails_post(hash)
      transformed_hash = Rails::Data.new(hash).transform
      post(transformed_hash)
    end

    def post(hash)
      Client.post(default_hash.merge(hash))
    end

    private

    def default_hash
      hash = { environment: environment}
      hash[:service] = service if service
      hash[:service_name] = service_name if service_name
      hash
    end

    def check_required_keys
      if uri.nil? or key.nil? or environment.nil?
        message = [
          "Required keys (uri, key, and environment) must",
          "be defined in the Limbo configure block"].join(" ")
        fail ArgumentError, message
      end
    end
  end
end

