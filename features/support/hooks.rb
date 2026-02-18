Before('@zap') do
  zap_path = ENV.fetch('ZAP_PATH', nil)
  if zap_path && File.exist?(zap_path)
    IO.popen([zap_path, '-daemon', '-config', 'api.disablekey=true'])
    sleep 10
  end

  if ENV['ZAP_SCAN'] == 'true' && zap_running?
    Capybara.current_driver = :firefox_zap
    Capybara.default_max_wait_time = 20
    puts "ZAP: Proxying traffic through #{zap_api_url}"
  end
end

After('@zap') do
  if Capybara.current_driver == :firefox_zap
    check_zap_alerts!
    Capybara.use_default_driver
    Capybara.default_max_wait_time = 10
  end
end

Before('@hwf_submit_application') do
  url = ENV.fetch('SUBMISSION_URL', nil)
  response = { result: true, message: 'HWF-000-000' }
  stub_request(:post, "#{url}/api/submissions").to_return(status: 200, body: response.to_json)
end

Before do
  stub_request(:any, 'https://dc.services.visualstudio.com/v2/track')
end
