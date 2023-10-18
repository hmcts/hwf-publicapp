RSpec.shared_examples 'cache suppress headers' do
  it 'sets headers to suppress browser cache' do
    expect(response.headers.to_h).to include(
      "x-frame-options" => "SAMEORIGIN",
      "x-xss-protection" => "0",
      "x-content-type-options" => "nosniff",
      "x-permitted-cross-domain-policies" => "none",
      "referrer-policy" => "strict-origin-when-cross-origin",
      "content-type" => "text/html; charset=utf-8",
      "cache-control" => "private, no-store",
      "pragma" => "no-cache",
      "expires" => "Fri, 01 Jan 1990 00:00:00 GMT"
    )
  end
end
