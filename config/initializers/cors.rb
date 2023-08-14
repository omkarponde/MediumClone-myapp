Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change to your frontend's domain

    resource(
       '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'Authorization'],
      methods: [:get, :post, :put, :patch, :delete, :options, :show],
    )
  end
end
