Rails.application.config.session_store :redis_store, {
  servers: [
    {
      host: ENV["REDIS_HOST"] || "localhost",
      port: ENV["REDIS_PORT"] || 6379,
      db: 0,
      password: ENV["REDIS_PASSWORD"],
      namespace: "session"
    },
  ],
  expire_after: 90.minutes
}
