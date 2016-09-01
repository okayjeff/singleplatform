require 'singleplatform/request'
require 'singleplatform/response'
require 'singleplatform/client/locations'
require 'singleplatform/client/menus'
require 'singleplatform/client/photos'
require 'cgi'
require 'uri'

module Singleplatform
  class Client
    attr_accessor :base_url, :client_id, :client_secret

    BASE_URL      = 'http://publishing-api.singleplatform.com'

    include Singleplatform::Client::Locations
    include Singleplatform::Client::Menus
    include Singleplatform::Client::Photos

    # Initializes a new API Client Object
    #
    # @return [Singleplatform::Client]
    def initialize(args = {})
      @base_url      = BASE_URL
      @client_id     = args[:client_id]
      @client_secret = args[:client_secret]
    end

    private

    # Form the complete URL for a given endpoint
    # 
    # @note Signature must be the last parameter
    #
    # @param path [String]
    # @param params [Hash]
    # @return [String]
    def generate_url(path, params = {})
      params['client'] ||= client_id
      signature_base_string = "#{path}?#{URI.encode_www_form(params)}"
      "#{base_url}#{signature_base_string}&signature=#{generate_signature(signature_base_string)}"
    end

    # Calculate the signature, Base64 and URL encode it
    #
    # @param base_string [String]
    # @return [String]
    def generate_signature(base_string)
      key = OpenSSL::HMAC.digest('sha1', client_secret, base_string)
      CGI::escape(Base64.encode64(key).chomp)
    end
  end
end