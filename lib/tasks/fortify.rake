namespace :fortify do
  desc 'Run Fortify Static Code Analyzer scan'
  task :scan do
    puts "Running Fortify scan..."
    
    # Clean previous scan results
    system("rm -rf fortify_results")
    system("mkdir -p fortify_results")
    
    # Build the project for Fortify analysis
    puts "Building project for Fortify analysis..."
    unless system("sourceanalyzer -b hwf-publicapp -clean")
      raise "Failed to clean Fortify build"
    end
    
    # Translate Ruby source code for analysis
    puts "Translating Ruby source code..."
    unless system("sourceanalyzer -b hwf-publicapp app/ lib/ config/ -exclude spec/ -exclude test/ -exclude features/")
      raise "Failed to translate source code for Fortify analysis"
    end
    
    # Run the scan
    puts "Running Fortify scan and generating report..."
    unless system("sourceanalyzer -b hwf-publicapp -scan -f fortify_results/hwf-publicapp.fpr")
      raise "Failed to run Fortify scan"
    end
    
    # Generate readable report
    if system("which ReportGenerator > /dev/null 2>&1")
      puts "Generating HTML report..."
      system("ReportGenerator -format html -f fortify_results/hwf-publicapp.html -source fortify_results/hwf-publicapp.fpr")
    end
    
    puts "Fortify scan completed. Results available in fortify_results/"
  end
  
  desc 'Upload Fortify results to Fortify on Demand'
  task :upload do
    puts "Uploading results to Fortify on Demand..."
    
    fod_user = ENV['FORTIFY_USER_NAME']
    fod_pass = ENV['FORTIFY_PASSWORD']
    
    if fod_user.nil? || fod_pass.nil?
      puts "Warning: FORTIFY_USER_NAME or FORTIFY_PASSWORD not set. Skipping upload."
      next
    end
    
    # Check if FPR file exists
    fpr_file = "fortify_results/hwf-publicapp.fpr"
    unless File.exist?(fpr_file)
      raise "Fortify scan results file not found: #{fpr_file}. Run 'rake fortify:scan' first."
    end
    
    # Upload to Fortify on Demand (this would typically use fcli or similar tool)
    puts "Note: Upload functionality requires Fortify CLI tools to be configured"
    puts "FPR file ready for upload: #{fpr_file}"
  end
end

# Default fortify task runs scan
desc 'Run Fortify Static Code Analyzer scan'
task :fortify => 'fortify:scan'
