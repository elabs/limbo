module Limbo
  class RailsData
    def initialize(hash)
      raise ArgumentError unless hash.is_a?(Hash)

      @params = hash.fetch(:params) { fail ArgumentError }
      @session = hash.fetch(:session) { fail ArgumentError }
      @exception = hash.fetch(:exception) { fail ArgumentError }
      @request = hash.fetch(:request) { fail ArgumentError }
    end

    def transform
      {
        controller:  @params[:controller],
        action:      @params[:action],
        parameters:  filter_sensitive_parameters(@params),
        url:         assemble_request_url,
        session:     filter_sensitive_parameters(@session.to_hash),
        # We must filter this better.
        #request_env: filter_sensitive_parameters(@request.env)
        backtrace:    @exception.backtrace
      }
    end

    private

    def filter_sensitive_parameters(hash)
      if hash.is_a?(Hash)
        sensitive_parameters = Rails.application.config.filter_parameters
        ActionDispatch::Http::ParameterFilter.new(sensitive_parameters).filter(hash)
      else
        hash
      end
    end

    def assemble_request_url
      url = "#{@request.protocol}#{@request.host}"

      unless [80, 443].include?(@request.port)
        url << ":#{@request.port}"
      end

      url << @request.fullpath
      url
    end
  end
end
