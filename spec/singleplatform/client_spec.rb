require 'singleplatform'

describe Singleplatform::Client do
  before do
    @creds = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
    @path   = '/locations/updated_since/'
    @params = { date: '2016-08-01', limit: 100 }
    @client = Singleplatform::Client.new(@creds)
    @url = 'http://publishing-api.singleplatform.com/locations/updated_since/?date=2016-08-01&limit=100&client=purplespacesuitfrogboots1&signature=D4mf0vL2jwJKU02OawPlXFXQymg%3D'
  end

  describe ".new" do
    context "given API credentials" do
      it "returns a Singleplatform::Client object" do
        expect(Singleplatform.new(@creds)).to be_a(Singleplatform::Client)
      end
    end

    context "without API credentials" do
      it "raises a MissingCredentialsError" do
        expect { Singleplatform.new }.
          to raise_error(Singleplatform::Error::MissingCredentialsError)
      end
    end
  end
end