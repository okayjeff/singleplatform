require 'minitest/autorun'
require 'singleplatform'

class SingleplatformTest < Minitest::Test
  def test_new_creates_new_client_object
    client = Singleplatform.new
    assert client.class == Client
  end
end