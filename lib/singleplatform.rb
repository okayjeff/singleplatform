require 'singleplatform/client'

module Singleplatform

  class << self

    # Alias for Singleplatform::Client.new
    #
    # @return [Singleplatform::Client]

    def new
      Singleplatform::Client.new
    end
  end
end