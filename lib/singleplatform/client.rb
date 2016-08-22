require 'singleplatform/client/request'
require 'singleplatform/client/locations'
require 'singleplatform/client/menus'
require 'singleplatform/client/photos'

module Singleplatform
  class Client
    BASE_URL      = ENV['BASE_URL'].freeze
    API_KEY       = ENV['API_KEY'].freeze
    CLIENT_ID     = ENV['CLIENT_ID'].freeze
    CLIENT_SECRET = ENV['CLIENT_SECRET'].freeze

    include Singleplatform::Client::Locations
    include Singleplatform::Client::Menus
    include Singleplatform::Client::Photos

    # Initializes a new API Client Object
    #
    # @return [Singleplatform::Client]
    def initialize
      @base_url      = BASE_URL
      @client_id     = CLIENT_ID
      @client_secret = CLIENT_SECRET
    end

    private

    # Form the complete URL for a given endpoint
    # @note Signature must be the last parameter
    #
    # @param path [String]
    # @param params [Hash]
    # @return [String]
    def generate_url(path, params = {})
      query_string = ''
      params.each do |k, v|
        query_string += "#{k}=#{v}&"
      end
      signature_base_string = "#{path}?#{query_string}client=#{@client_id}"
      "#{@base_url}#{signature_base_string}&signature=#{generate_signature(signature_base_string)}"
    end

    # Calculate the signature, Base64 encode it and URL encode
    #
    # @param base_string [String]
    # @return [String]
    def generate_signature(base_string)
      key = OpenSSL::HMAC.digest('sha1', @client_secret, base_string)
      CGI::escape(Base64.encode64(key).chomp)
    end
  end
end