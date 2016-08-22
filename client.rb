require 'dotenv'
Dotenv.load

require_relative 'client/request'
require_relative 'client/locations'
require_relative 'client/menus'

module Singleplatform
  class Client
    BASE_URL = ENV['BASE_URL'].freeze
    API_KEY = ENV['API_KEY'].freeze
    CLIENT_ID = ENV['CLIENT_ID'].freeze
    CLIENT_SECRET = ENV['CLIENT_SECRET'].freeze

    include Singleplatform::Client::Locations
    include Singleplatform::Client::Menus

    def initialize
      @base_url      = BASE_URL
      @client_id     = CLIENT_ID
      @client_secret = CLIENT_SECRET
    end

    private

    def generate_url(path, params = {})
      query_string = ''
      params.each do |k, v|
        query_string += "#{k}=#{v}&"
      end
      signature_base_string = "#{path}?#{query_string}client=#{@client_id}"
      "#{@base_url}#{signature_base_string}&signature=#{generate_signature(signature_base_string)}"
    end

    def generate_signature(base_string)
      key = OpenSSL::HMAC.digest('sha1', @client_secret, base_string)
      CGI::escape(Base64.encode64(key).chomp)
    end
  end
end