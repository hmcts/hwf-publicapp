namespace :fortify_scan do
  desc 'Fortify scan'
  task :run do
    puts "Building project for Fortify analysis..."
    unless system("sourceanalyzer -b hwf-publicapp -clean")
      raise "Failed to run Fortify build"
    end
  end
end

desc 'Fortify scan'
task :fortify_scan => 'fortify_scan:run'
