# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [
      "https://cash-register-frontend.vercel.app",
      "https://cash-register-frontend-git-main-emiliarojos-projects.vercel.app",
      "https://cash-register-frontend-o6megpyx3-emiliarojos-projects.vercel.app",
      "http://localhost:3000/",
      "http://192.168.1.33:3000"
    ]
    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true,
      same_site: :none
  end
end
