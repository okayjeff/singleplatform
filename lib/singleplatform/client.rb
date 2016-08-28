require 'singleplatform/client/request'
require 'singleplatform/client/locations'
require 'singleplatform/client/menus'
require 'singleplatform/client/photos'

module Singleplatform
  class Client
    BASE_URL      = 'http://publishing-api.singleplatform.com'
    CLIENT_ID     = ENV['CLIENT_ID'].freeze
    CLIENT_SECRET = ENV['CLIENT_SECRET'].freeze

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

    # Form the complete URL for a given endpoint
    # @note Signature must be the last parameter
    #
    # @note For convenience, @param path can also be a complete URL,
    # which enables you to call generate_url(response.next) when
    # paginating through updated_since results. See 
    # Client#form_path_from_url.
    #
    # @param path [String]
    # @param params [Hash]
    # @return [String]
    def generate_url(path, params = {})
      path.gsub!(@base_url, '')
      params['client'] = @client_id
      signature_base_string = "#{path}?#{URI.encode_www_form(params)}"
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

    def form_path_from_url(url); end
  end
end