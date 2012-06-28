require 'net/http'
require "json"

module Limbo
  class Client
    def self.post(hash)
      new(hash).post
    end

    def post
      headers =  { "X-LIMBO-KEY" => Limbo.key,
                   "content-type" => "application/json"}
      path = '/log'
      request = Net::HTTP::Post.new(path, headers)

      uri = URI(Limbo.uri)
      port = uri.port || 80
      Net::HTTP.start(uri.host, port) do |http|
        http.open_timeout = 5
        http.request(request, body)
      end
    end

    private

    def body
      begin
        JSON.generate(@body)
      rescue JSON::GeneratorError
        '{"client-error": "error generating JSON"}'
      end
    end

    def initialize(body)
      @body = body
    end
  end
end
