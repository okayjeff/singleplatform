require 'minitest/autorun'
require 'singleplatform'

class Singleplatform::ClientTest < Minitest::Test
  def test_urls_generate_correctly
    client = Singleplatform::Client.new(
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    )
    path   = '/locations/updated_since/'
    params = { date: '2016-08-01', limit: 100 }
    url = client.generate_url(path, params)
    assert_equal('http://publishing-api.singleplatform.com/locations/updated_since/?date=2016-08-01&limit=100&client=purplespacesuitfrogboots1&signature=D4mf0vL2jwJKU02OawPlXFXQymg%3D', url)
  end
end