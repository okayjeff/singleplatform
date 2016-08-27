require 'minitest/autorun'
require 'singleplatform'

class SingleplatformTest < Minitest::Test
  def test_new_creates_new_client_object
    client = Singleplatform.new(
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    )
    assert_instance_of(Singleplatform::Client, client)
  end
end