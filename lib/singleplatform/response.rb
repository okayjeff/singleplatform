module Singleplatform
  class Response
    attr_accessor :code, :body

    def initialize(args)
      @code = args[:code]
      @body = args[:body]
    end

    def next; end
  end
end