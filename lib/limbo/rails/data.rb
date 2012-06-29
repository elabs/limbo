require 'limbo/rails/parameter_filter'
require 'limbo/rails/request'

module Limbo
  module Rails
    class Data
      def initialize(hash)
        fail ArgumentError, 'Argument must be a hash' unless hash.is_a?(Hash)

        message = 'Required keys are: :params, :session, :exception, :request'

        @params = hash.delete(:params) { fail ArgumentError, message }
        @session = hash.delete(:session) { fail ArgumentError, message }
        @exception = hash.delete(:exception) { fail ArgumentError, message }
        request = hash.delete(:request) { fail ArgumentError, message }
        @request = Limbo::Rails::Request.new(request)

        @hash = hash
      end

      def transform
        {
          controller:  @params[:controller],
          action:      @params[:action],
          parameters:  Limbo::Rails::ParameterFilter.filter(@params),
          url:         @request.url,
          session:     Limbo::Rails::ParameterFilter.filter(@session.to_hash),
          # TODO: We must filter this better.
          # request_env: Limbo::RailsParameterFilter.filter(@request.env)
          backtrace:    @exception.backtrace
        }.merge(@hash)
      end
    end
  end
end
