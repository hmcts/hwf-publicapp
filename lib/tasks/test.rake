task :test => :environment do
  puts ENV.fetch('SUBMISSION_URL', 'submission url not loaded')
  unless system("rspec -t ~smoke --format RspecJunitFormatter --out tmp/test/rspec.xml")
    raise "Rspec testing failed #{$?}"
  end

  unless system "bundle exec rubocop"
    raise "Rubocop failed"
  end
end

# namespace :test do
#   task smoke: :environment do
#     if system "bundle exec cucumber features/  --tags @hwf_submit_application"
#       puts "Smoke test passed"
#     else
#       raise "Smoke tests failed"
#     end
#   end

#   task functional: :environment do
#     if system "bundle exec cucumber features/"
#       puts "Functional test passed"
#     else
#       raise "Functional tests failed"
#     end
#   end
# end
