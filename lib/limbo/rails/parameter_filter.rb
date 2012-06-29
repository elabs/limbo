module Limbo
  module Rails
    class ParameterFilter
      def self.filter(hash)
        if hash.is_a?(Hash)
          filter = ::Rails.application.config.filter_parameters
          ActionDispatch::Http::ParameterFilter.new(filter).filter(hash)
        else
          hash
        end
      end
    end
  end
end
