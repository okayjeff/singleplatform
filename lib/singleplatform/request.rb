require 'httparty'
require 'hashie'

module Singleplatform
  class Request
    # Make an HTTP get request to given URL
    #
    # @param url [String]
    # @return [Singleplatform::Response]
    def self.get(url)
      tries ||= 3
      response = HTTParty.get(url)
    rescue
      sleep 3
      retry if (tries -= 1) > 0
      raise Error::RequestError
    else
      raise(
        Error::ApiError,
        "#{response.code}: #{response['errorMessage']}"
      ) if response.code != 200
      Response.new(
        code:   response.code,
        body:   self.parse_response_body(response.body),
        # Pass the calling method to the Response object so Response#next 
        # knows which method to call when API results are iterable.
        origin: caller_locations(1,1)[0].label
      )
    end

    # Transform API JSON response to Hashie::Mash pseudo object
    #
    # @return [Hashie::Mash]
    def self.parse_response_body(body)
      return body unless JSON.parse(body)
      Hashie::Mash.new(JSON.parse(body)).data
    end
  end
end