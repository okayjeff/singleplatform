require 'httparty'
require 'hashie'

module Singleplatform
  class Request
    # Make an HTTP get request to given URL
    #
    # @param url [String]
    # @return [Hashie::Mash]
    def self.get(url)
      tries ||= 3
      response = HTTParty.get(url)
    rescue
      sleep 3
      if tries -= 1 > 0
        retry
      end
      nil
    else
      raise Singleplatform::Error.new(response.errorMessage) if response.code != 200
      Response.new(
        code: response.code,
        body: self.parse_response_body(response.body)
      )
    end

    def self.parse_response_body(body)
      return body unless JSON.parse(body)
      Hashie::Mash.new(JSON.parse(body)).data
    end
  end
end