require 'net/http'
require 'json'

def zap_api_url
  host = ENV.fetch('ZAP_PROXY_HOST', 'localhost')
  port = ENV.fetch('ZAP_PROXY_PORT', '8080')
  "http://#{host}:#{port}"
end

def zap_alerts
  uri = URI("#{zap_api_url}/JSON/core/view/alerts/")
  uri.query = URI.encode_www_form(zapapiformat: 'JSON', baseurl: Capybara.app_host)
  response = Net::HTTP.get(uri)
  JSON.parse(response)['alerts']
end

def zap_high_alerts
  zap_alerts.select { |alert| alert['risk'] == 'High' }
end

def print_zap_alerts
  zap_alerts.each { |alert| puts "ZAP: #{alert['alert']} [#{alert['risk']}]" }
end

def check_zap_alerts!
  all_alerts = zap_alerts
  puts "ZAP: Connected to #{zap_api_url} - #{all_alerts.size} alert(s) found"
  all_alerts.each { |alert| puts "  ZAP [#{alert['risk']}] #{alert['alert']} - #{alert['url']}" }

  high = all_alerts.select { |alert| alert['risk'] == 'High' }
  return if high.empty?

  raise "ZAP found #{high.size} high risk alert(s)"
rescue Errno::ECONNREFUSED
  puts "ZAP: Not running on #{zap_api_url} - skipping alert check"
end
