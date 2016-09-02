require 'singleplatform'
require 'webmock/rspec'

describe Singleplatform::Client::Menus do

  before do
    @creds = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
    @client = Singleplatform::Client.new(@creds)
    @menus = File.open(Dir.pwd + '/spec/support/fixtures/menus.json').read
  end

  describe ".menus_for" do
    context "when given a valid location id" do
      it "returns menu data for that location" do
        stub_request(:get, /publishing-api.singleplatform.com/).
          with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: @menus)
        response = @client.menus_for('island-prime')
        expect(response).to be_a(Singleplatform::Response)
        expect(response.body.size).to eql(2)
      end
    end

    context "when missing a location id" do
      it "raises an ArgumentError" do
        expect { @client.menus_for }.to raise_error(ArgumentError) 
      end
    end

    context "when given an invalid location id" do
      it "raises an InvalidLocationError" do
        expect { @client.menus_for('') }.to raise_error(Singleplatform::Error::InvalidLocationError)
        expect { @client.menus_for(' ') }.to raise_error(Singleplatform::Error::InvalidLocationError)
      end
    end
  end

end