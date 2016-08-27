require 'minitest/autorun'
require 'webmock/minitest'
require 'singleplatform'

class Singleplatform::Client::LocationsTest < Minitest::Test
  def test_updated_since_fetches_locations
    url = /SinglePlatform::Client::BASE_URL\/locations\/updated_since*/
    response = File.read('test/fixtures/updated_since_response.json')
    stub_request(:get, url).
      with(
        body: response,
        headers: { "Content-Type" => 'application/json' }
      )
    client = Singleplatform::Client.new(
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    )
    client.locations_updated_since(date: '2012-11-16', limit: 11)
  end
end