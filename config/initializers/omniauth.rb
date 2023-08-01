Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, ENV['GITHUB_ID'], ENV['GITHUB_SECRET']
  else
    provider :github,
             Rails.application.credentials.github[:client_id],
             Rails.application.credentials.github[:client_secret]
  end
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
