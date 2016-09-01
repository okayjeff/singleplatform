require 'cgi'

module Singleplatform
  class Response
    attr_accessor :code, :body, :next_page

    def initialize(args)
      @code      = args[:code]
      @body      = args[:body]
      @next_page = args[:body].next
    end

    def next
      return nil if next_page.nil?
      params = parse_params(next_page)
      params['client'] ||= ENV['CLIENT_ID']
      client = Singleplatform.new(
        client_id:     ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET']
      )
      client.locations_updated_since(params)
    end

    def parse_params(url)
      CGI::parse(url.split('?')[-1])
    end
  end
end