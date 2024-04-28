# CashRegisterApi::Application.config.session_store :redis_store,
#   servers: ["redis://localhost:6379/0/session"],
#   expire_after: 90.minutes,
#   key: "_#{Rails.application.class.module_parent_name.downcase}_session",
#   threadsafe: true,
#   secure: true

CashRegisterApi::Application.config.session_store :redis_store,
  servers: [
    {
      url: ENV['REDIS_URL'],
      namespace: 'session'
    }
  ],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.module_parent_name.downcase}_session",
  threadsafe: true,
  secure: true
