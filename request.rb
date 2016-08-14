require 'httparty'

module Singleplatform
  class Request
    def get(url)
      tries = 3
      HTTParty.get(url)
    rescue
      sleep 5
      retry if tries -= 1 > 0
      nil
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end
  end
end