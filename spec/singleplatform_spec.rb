require 'singleplatform'

describe Singleplatform do

  before do
    @credentials = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
  end

  describe ".new" do
    context "given API credentials" do
      it "returns a Singleplatform::Client object" do
        expect(
          Singleplatform.new(@credentials)).to be_a(Singleplatform::Client)
      end
    end
  end

end