max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"
environment ENV.fetch("RAILS_ENV") { "development" }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Only use a pidfile when requested
pids_dir = "tmp/pids"
FileUtils.mkdir_p(pids_dir)
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch("PORT", 3000)

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
