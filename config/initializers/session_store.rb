if ENV["REDIS_URL"]
  CashRegisterApi::Application.config.session_store :redis_store, {
    servers: [{
      url: ENV["REDIS_URL"],
      serializer: :json
    }],
    expire_after: 90.minutes,
    key: "_#{Rails.application.class.module_parent_name.downcase}_session"
  }
end
