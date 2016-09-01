require 'singleplatform'

describe Singleplatform do

  before do
    @creds = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
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