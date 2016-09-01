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
      Response.new(
        code: response.code,
        body: parse_response_body(response.body)
      )
    end

    def parse_response_body(body)
      return body unless JSON.parse(body)
      Hashie::Mash.new(JSON.parse(response.body)).data
    end
  end
end