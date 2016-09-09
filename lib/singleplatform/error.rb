module Singleplatform
  module Error
    class Base < StandardError
      def initialize(msg)
        super(msg)
      end
    end

    class MissingCredentialsError < Base
      def initialize(msg = "You must initialize a client with ID and Secret.")
        super
      end
    end

    class ApiError < Base
      def initialize(msg = "Oops! There was an error.")
        super
      end
    end

    class RequestError < Base
      def initialize(msg = "Unable to transmit HTTP request to SinglePlatform.")
        super
      end
    end

    class MissingParametersError < Base
      def initialize(msg = "Your request is missing required parameters.")
        super
      end
    end

    class InvalidLocationError < Base
      def initialize(msg = "Your request must supply a valid location.")
        super
      end
    end

    class InvalidDateError < Base
      def initialize(msg = "Your request must supply a valid date.")
        super
      end
    end
  end
end