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
      
    end

    def parse_params(url)
      CGI::parse(url.split('?')[-1])
    end

    def parse_path(url)
      base_url = 'http://publishing-api.singleplatform.com'
      # CGI::parse(url.split('?')[0]).slice('')
    end
  end
end