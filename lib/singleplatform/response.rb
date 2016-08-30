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
      path = strip_base_url(next_page)
      path << "&client=#{ENV['CLIENT_ID']}"
      
    end

    def strip_base_url(url)
      url.slice!(/http:\/\/publishing-api.singleplatform.com/)
    end
  end
end