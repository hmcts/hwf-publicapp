task :test => :environment do
  unless system("rspec -t ~smoke --format RspecJunitFormatter --out tmp/test/rspec.xml")
    raise "Rspec testing failed #{$?}"
  end

  unless system "bundle exec rubocop"
    raise "Rubocop failed"
  end
end

namespace :test do
  task smoke: :environment do
    if system "bundle exec cucumber features/  --tags @hwf_submit_application"
      puts "Smoke test passed"
    else
      raise "Smoke tests failed"
    end
  end

  task functional: :environment do
    if system "bundle exec cucumber features/"
      puts "Functional test passed"
    else
      raise "Functional tests failed"
    end
  end

  task cross_browser_device: :environment do
    browsers = %w[playwright_chrome playwright_msedge playwright_firefox playwright_webkit]
    results = {}

    browsers.each do |browser|
      puts "Running tests on #{browser}"
      env = {
        "DRIVER" => browser,
      }
      results[browser] = system(env, "bundle exec cucumber features/ --tags @javascript")
    end

    puts "\n\n"
    puts "=== Playwright Results ==="
    results.each do |browser, result|
      puts "#{browser}: #{result ? 'Passed' : 'Failed'}"
    end
  end
end
