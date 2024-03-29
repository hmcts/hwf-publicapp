Before('@hwf_submit_application') do
  url = ENV.fetch('SUBMISSION_URL', nil)
  response = { result: true, message: 'HWF-000-000' }
  stub_request(:post, "#{url}/api/submissions").to_return(status: 200, body: response.to_json)
end

Before('@zap') do
  IO.popen('/Applications/ZAP\ 2.6.0.app/Contents/Java/zap.sh -daemon')
end

Before do
  stub_request(:any, 'https://dc.services.visualstudio.com/v2/track')
end
