module Singleplatform
  class Client
    module Locations
      # Fetch information about a specific location
      #
      # @param id [String]
      # @param options [Hash] :format Short menu ('short') available
      # @return [Hash]
      def location(id, options = {})
        url = generate_url("/locations/#{id}/", options)
        Request.get(url)
      end

      # Fetch all locations updated since a given date
      #
      # @param date [String]
      # @param options [Hash] :limit Maximum (default) 5000 per page
      # @return [Hash]
      def locations_updated_since(date, options = {})
        url = generate_url(
          '/locations/updated_since/',
          { date: date }.merge(options)
        )
        Request.get(url)
      end
    end
  end
end