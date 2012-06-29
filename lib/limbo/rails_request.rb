module Limbo
  class RailsRequest
    def initialize(request)
      @request = request
    end

    def url
      "#{@request.protocol}#{@request.host_with_port}#{@request.fullpath}"
    end
  end
end
