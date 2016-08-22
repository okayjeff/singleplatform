require 'httparty'

module Singleplatform
  class Request
    def self.get(url)
      tries ||= 3
      puts tries
      HTTParty.get(url)
    rescue Exception => e
      sleep 3
      if (tries -= 1) > 0
        retry
      else
        puts e
        nil
      end
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end
  end
end