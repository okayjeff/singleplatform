module Singleplatform
  class Response
    attr_accessor :code, :body, :next_url

    def initialize(args)
      @code = args[:code]
      @body = args[:body]
      @next_url = args[:body].next
    end

    def next
      
    end
  end
end