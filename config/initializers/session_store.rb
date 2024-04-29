Rails.application.config.session_store :cookie_store,
   same_site: :none,
   secure: Rails.env.production?,
   key: '_your_app_session'
