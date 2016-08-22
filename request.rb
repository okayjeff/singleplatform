require 'httparty'

module Singleplatform
  class Request
    def self.get(url)
      tries = 3
      HTTParty.get(url)
    rescue
      sleep 3
      retry if (tries -= 1) > 0
      nil
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end
  end
end