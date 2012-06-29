require 'limbo'
require 'rails/all'
require 'vcr'

module Dummy
  class Application < Rails::Application
  end
end

Dummy::Application.configure do
  config.active_support.deprecation = :log
end

Dummy::Application.initialize!

RSpec.configure do |config|
  config.fail_fast = true
  config.extend VCR::RSpec::Macros
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :fakeweb
end

def request(options = {})
  port = options.fetch(:port) { 80 }
  env = {
    'HTTP_HOST' => "example.com:#{port}",
    'rack.url_scheme' => 'http',
    'SCRIPT_NAME' => '',
    'PATH_INFO' => '/blog'
  }
  ActionDispatch::Request.new(env)
end
