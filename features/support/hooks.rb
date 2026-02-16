Before('@zap') do
  zap_path = ENV.fetch('ZAP_PATH', nil)
  if zap_path && File.exist?(zap_path)
    IO.popen([zap_path, '-daemon', '-config', 'api.disablekey=true'])
    sleep 10
  end
end

After('@zap') do
  if ENV.fetch('DRIVER', nil) == 'firefox_zap'
    check_zap_alerts!
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
