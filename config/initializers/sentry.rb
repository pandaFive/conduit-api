Sentry.init do |config|
  config.dsn = "https://724e1197985af3d974ea88732f8de33a@o4506807756849152.ingest.sentry.io/4506807763664896"
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
