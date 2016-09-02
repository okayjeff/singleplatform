require 'singleplatform'
require 'webmock/rspec'

describe Singleplatform::Client::Photos do

  before do
    @creds = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
    @client = Singleplatform::Client.new(@creds)
    @photos = File.open(Dir.pwd + '/spec/support/fixtures/photos.json').read
  end

  describe ".photos_for" do
    context "when given a valid location id" do
      it "returns photos for that location" do
        stub_request(:get, /publishing-api.singleplatform.com/).
          with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: @photos)
          response = @client.photos_for('island-prime')
          expect(response).to be_a(Singleplatform::Response)
          expect(response.body.first.title).to eql('Key Lime Pie')
      end
    end
    
    context "when missing a location id" do
      it "raises an ArgumentError" do
        expect { @client.photos_for }.to raise_error(ArgumentError)
      end
    end
  end

end