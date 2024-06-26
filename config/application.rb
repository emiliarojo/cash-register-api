require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module CashRegisterApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # API only configuration
    config.api_only = true

    # Manually add middleware for session and cookies
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.autoload_lib(ignore: %w(assets tasks))
  end
end
