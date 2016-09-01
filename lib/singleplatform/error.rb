module Singleplatform
  module Error
    class Base < StandardError
      def initialize(msg)
        super(msg)
      end
    end

    class MissingCredentials < Base
      def initialize(msg = "You must initialize a client with ID and Secret.")
        super
      end
    end

    class ApiError < Base
      def initialize(msg = "Oops! There was an error.")
        super
      end
    end

    class MissingParameters < Base
      def initialize(msg = "Your request is missing required parameters.")
        super
      end
    end
  end
end