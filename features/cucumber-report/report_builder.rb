require 'report_builder'
require 'date'

at_exit do
  current_time = DateTime.now

  ReportBuilder.configure do |config|
    config.input_path = 'features/cucumber-report/cucumber_report.json'
    config.report_path = 'features/cucumber-report/cucumber_report'
    config.report_types = [:html]
    config.report_tabs = %w[Overview Features Scenarios Errors]
    config.report_title = 'Cucumber test results'
    config.compress_images = false
    config.additional_info = { 'Project name' => 'Help With Fees', 'Platform' => 'Public', 'Report generated' => current_time.strftime("%d/%m/%Y %H:%M") }
  end

  ReportBuilder.build_report
end
