require 'singleplatform/request'
require 'singleplatform/response'
require 'singleplatform/error'
require 'singleplatform/client/locations'
require 'singleplatform/client/menus'
require 'singleplatform/client/photos'
require 'cgi'
require 'uri'

module Singleplatform
  class Client
    attr_accessor :base_url, :client_id, :client_secret

    BASE_URL = 'http://publishing-api.singleplatform.com'

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
      raise Error::MissingCredentialsError if credentials_missing?
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

    # Helper method to determine if credentials are missing and, if
    #   so, raise Error::MissingCredentials
    #
    # @return [Boolean]
    def credentials_missing?
      client_id.nil? || client_secret.nil?
    end

    # Helper method to determine if any number of params are nil,
    #   empty or just spaces.
    #
    # @return [Boolean]
    def valid_params?(*args)
      args.map { |a| return false if a.nil? || a.to_s.gsub(/\s/, '').empty? }
      true
    end

    # Helper method to determine if a date is valid
    #
    # @return [Boolean]
    def valid_date?(date)
      y, m, d = date.to_s.split('-')
      Date.valid_date?(y.to_i, m.to_i, d.to_i)
    rescue TypeError
      return false
    end
  end
end