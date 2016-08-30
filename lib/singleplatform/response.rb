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
      path = parse_params(next_page)
      puts "Stripped base url: " + path
      path << "&client=#{ENV['CLIENT_ID']}"
    end

    def parse_params(url)
      CGI::parse(url.slice!(/[?].+/))
    end
  end
end