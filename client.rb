require 'dotenv'
Dotenv.load
require 'base64'
require 'openssl'
require 'cgi'
require 'json'

module Singleplatform
  class Client
    HOST = ENV['HOST'].freeze
    API_KEY = ENV['API_KEY'].freeze
    CLIENT_ID = ENV['CLIENT_ID'].freeze
    CLIENT_SECRET = ENV['CLIENT_SECRET'].freeze

    def initialize
      @client_id = CLIENT_ID
      @client_secret = CLIENT_SECRET
    end

    def locations(id)
      tries ||= 3
      url = generate_url("/locations/#{id}/")
      response = HTTParty.get(url)
    rescue
      sleep 5
      retry if tries -= 1 > 0
      return false
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end

    def locations_updated_since(date)
      tries ||= 3
      url = generate_url('/locations/updated_since/', date: date)
      response = HTTParty.get(url)
    rescue
      sleep 5
      retry if tries -= 1 > 0
      return false
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end

    def generate_url(path, params = {})
      query_string = ''
      params.each do |k, v|
        query_string += "#{k}=#{v}&"
      end
      signature_base_string = "#{path}?#{query_string}client=#{CLIENT_ID}"
      "#{HOST}#{signature_base_string}&signature=#{generate_signature(signature_base_string)}"
    end

    def generate_signature(base_string)
      key = OpenSSL::HMAC.digest('sha1', CLIENT_SECRET, base_string)
      CGI::escape(Base64.encode64(key).chomp)
    end
  end
end