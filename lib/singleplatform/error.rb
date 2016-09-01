module Singleplatform
  class Error < StandardError
    attr_reader :code
    def initialize(msg='Oops! Something went wrong.', code)
      @code = code
      super(msg)
    end
  end
end