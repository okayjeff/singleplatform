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

    class MissingParametersError < Base
      def initialize(msg = "Your request is missing required parameters.")
        super
      end
    end

    class InvalidParametersError < Base
      def initialize(msg = "Your request is missing required parameters.")
        super
      end
    end

    class InvalidDateError < InvalidParametersError
      def initialize(msg = "Your request must supply a valid date.")
        super
      end
    end
  end
end