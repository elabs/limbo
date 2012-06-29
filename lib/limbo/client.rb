require 'net/http'
require "json"

module Limbo
  class Client
    def self.post(hash)
      new(hash).post
    end

    def valid_data?
      @valid_data
    end

    def posted?
      200 == response.code.to_i
    end

    def response
      @response
    end

    def post
      headers =  { "X-LIMBO-KEY" => Limbo.key,
                   "content-type" => "application/json"}
      path = '/log'
      request = Net::HTTP::Post.new(path, headers)

      uri = URI(Limbo.uri)
      port = uri.port || 80
      @response = Net::HTTP.start(uri.host, port) do |http|
        http.open_timeout = 5
        http.request(request, body)
      end

      self
    end

    private

    def body
      begin
        JSON.generate(@body)
      rescue JSON::GeneratorError
        @valid_data = false
        '{"client-error": "error generating JSON"}'
      end
    end

    def initialize(body)
      @body = body
      @valid_data = true
    end
  end
end
