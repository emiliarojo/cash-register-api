# config/application.rb or config/initializers/session_store.rb
Rails.application.config.session_store :redis_store, servers: [{ url: ENV['REDIS_URL'] }], expire_after: 90.minutes, key: '_your_app_session'
