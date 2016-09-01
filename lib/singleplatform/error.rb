module Singleplatform
  module Error
      class Base < StandardError
        def initialize(msg)
          super(msg)
        end
      end

      class MissingCredentials < Base
        def initialize(msg = "You must initialize a client with ID and Secret")
          super
        end
      end
  end
end