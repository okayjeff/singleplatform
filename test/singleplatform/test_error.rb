require 'minitest/autorun'
require 'singleplatform'

class Singleplatform::ErrorTest < Minitest::Test
  def test_missing_credentials_error
    assert_raises(
      Singleplatform::Error::MissingCredentialsError
    ) { Singleplatform::Client.new }
    client = Singleplatform::Client.new(
      client_id:     'x',
      client_secret: 'y'
    )
    assert_instance_of(Singleplatform::Client, client)
  end
end