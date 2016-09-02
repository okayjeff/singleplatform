require 'singleplatform'
require 'webmock/rspec'
require 'spec_helper'

describe 'Singleplatform::Client::Locations' do

  before do
    @creds = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
    @client = Singleplatform::Client.new(@creds)
    @location = File.open(Dir.pwd + '/spec/support/fixtures/location.json').read
    @updated_since = File.open(Dir.pwd + '/spec/support/fixtures/updated_since.json').read
  end

  describe ".location" do
    context "when given a valid location id" do
      it "returns data for that location" do
        stub_request(:get, /publishing-api.singleplatform.com/).
          with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: @location)
        response = @client.location('island-prime')
        expect(response).to be_a(Singleplatform::Response)
        expect(response.body.location_id).to eql('island-prime')
      end
    end

    context "when missing a location id" do
      it "raises an ArgumentError" do
        expect { @client.location }.to raise_error(ArgumentError)
      end
    end

    context "when including too many params" do
      it "raises an ArgumentError" do
        expect { @client.location('island-prime', 'another-argument') }.to raise_error(ArgumentError)
      end
    end

    context "when given an invalid location id" do
      it "raises an InvalidLocationError" do
        expect { @client.location('') }.to raise_error(Singleplatform::Error::InvalidLocationError)
        expect { @client.location(' ') }.to raise_error(Singleplatform::Error::InvalidLocationError)
      end
    end
  end

  describe ".locations_updated_since" do
    context "when given a valid date" do
      it "returns locations updated since that date" do
        stub_request(:get, /publishing-api.singleplatform.com/).
          with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: @updated_since)
        response = @client.locations_updated_since('2012-01-01', limit: 3)
        expect(response).to be_a(Singleplatform::Response)
        expect(response.body.results.size).to eql(3)
      end
    end

    context "when missing a date" do
      it "raises an ArgumentError" do 
        expect { @client.locations_updated_since }.to raise_error(ArgumentError
          )
      end
    end

    context "when given an invalid date" do
      it "raises an InvalidDateError" do
        expect { @client.locations_updated_since(' ') }.to raise_error(Singleplatform::Error::InvalidDateError)
        expect { @client.locations_updated_since('2016') }.to raise_error(Singleplatform::Error::InvalidDateError)
        expect { @client.locations_updated_since('2016-9') }.to raise_error(Singleplatform::Error::InvalidDateError)
        expect { @client.locations_updated_since('2016-9-') }.to raise_error(Singleplatform::Error::InvalidDateError)
        expect { @client.locations_updated_since('2016-9-31') }.to raise_error(Singleplatform::Error::InvalidDateError)
      end
    end
  end

  describe ".all" do
    context "when given a valid location id" do
      it "returns location info, menus and photos" do
        # TODO
      end
    end
  end
  
end