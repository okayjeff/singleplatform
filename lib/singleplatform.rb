require 'singleplatform/client'

module Singleplatform

  class << self

    # Alias for Singleplatform::Client.new
    #
    # @return [Singleplatform::Client]
    def new(args = {})
      Singleplatform::Client.new(args)
    end

  end
end