require 'httparty'
require 'json'
require 'hashie'

module Singleplatform
  class Request
    def self.get(url)
      tries ||= 3
      response = HTTParty.get(url)
    rescue Exception => e
      sleep 3
      if tries -= 1 > 0
        retry
      else
        nil
      end
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end
  end
end