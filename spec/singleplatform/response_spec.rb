require 'singleplatform'
require 'webmock/rspec'
require 'spec_helper'

describe Singleplatform::Response do

  before do
    @creds = {
      client_id:     'purplespacesuitfrogboots1',
      client_secret: 'yellowsubmarinesresonatewithmeandmybestbros'
    }
    ENV['SINGLEPLATFORM_CLIENT_ID'] = @creds[:client_id]
    ENV['SINGLEPLATFORM_CLIENT_SECRET'] = @creds[:client_secret]
    @client = Singleplatform::Client.new(@creds)
    @updated_since = File.open(Dir.pwd + '/spec/support/fixtures/updated_since.json').read
  end

  describe ".next" do
    context "when next_page is nil" do
      it "returns nil" do
        response = Singleplatform::Response.new(
          code:      200,
          body:      nil,
          origin:    :locations_updated_since,
          next_page: nil
        )
        expect(response.next.nil?).to be
      end
    end

    context "when next_page is empty" do
      it "returns nil" do
        response = Singleplatform::Response.new(
          code:      200,
          body:      nil,
          origin:    :locations_updated_since,
          next_page: ''
        )
        expect(response.next.nil?).to be
      end
    end
    
    context "when origin = updated_since" do
      it "returns updated_since results" do
        response = Singleplatform::Response.new(
          code:      200,
          body:      @updated_since,
          origin:    :locations_updated_since,
          next_page: "http://publishing-api.singleplatform.com/locations/updated_since/?date=2016-09-01T00:00:02&limit=2&last_record_id=22494"
        )
        stub_request(:get, /publishing-api.singleplatform.com/).
          with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: @updated_since)
        next_page = response.next
        expect(next_page).to be_a(Singleplatform::Response)
        expect(next_page.body.results.size).to eql(3)
      end
    end
  end

end
