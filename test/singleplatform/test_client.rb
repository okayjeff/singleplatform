require 'minitest/autorun'
require 'singleplatform'

class Singleplatform::ClientTest < Minitest::Test
  def test_urls_generate_correctly
    class Singleplatform::Client
      BASE_URL      = 'http://publishing-api.singleplatform.com'.freeze
      CLIENT_ID     = 'purplespacesuitfrogboots1'.freeze
      CLIENT_SECRET = 'yellowsubmarinesresonatewithmeandmybestbros'.freeze
    end
    skip
    path   = '/locations/updated_since/'
    params = { date: '2016-08-01', limit: 10 }
    url = generate_url(path, params)
    
  end
end