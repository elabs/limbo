require 'limbo'
require 'rails/all'

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
