namespace :fortify_scan do
  desc 'fortify scan'
  task :run do
    puts "Building project for Fortify analysis..."
    unless system("sourceanalyzer -b hwf-publicapp -clean")
      raise "Failed to run Fortify build"
    end
  end
end

desc 'fortify scan'
task :fortifyScan => 'fortify_scan:run'
