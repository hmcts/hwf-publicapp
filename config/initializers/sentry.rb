EXCLUDE_PATHS = ['/ping', '/ping.json', '/health', '/health.json'].freeze

Sentry.init do |config|
  config.dsn = Settings.sentry.dsn
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # REVISION is written by Jenkinsfile_CNP before the image build; see CHANGELOG.md
  revision = Rails.root.join('REVISION')
  config.release = "publicapp@#{revision.read.strip}" if revision.exist?

  config.traces_sampler = lambda do |sampling_context|
    transaction_context = sampling_context[:transaction_context]
    transaction_name = transaction_context[:name]

    transaction_name.in?(EXCLUDE_PATHS) ? 0.0 : 0.01
  end
end
