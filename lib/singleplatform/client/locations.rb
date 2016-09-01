module Singleplatform
  class Client
    module Locations
      # Fetch information about a specific location
      #
      # @param id [String]
      # @param options [Hash]
      # @option options [String] :format Short menu ('short') available
      # @return [Hashie::Mash]
      def location(id, options = {})
        url = generate_url("/locations/#{id}/", options)
        Request.get(url)
      end

      # Fetch all locations updated since a given date
      #
      # @param date [String]
      # @param options [Hash]
      # @option options [Fixnum] :limit Maximum (default) 5000 per page
      # @return [Hashie::Mash]
      def locations_updated_since(options = {})
        url = generate_url(
          '/locations/updated_since/',
          # { date: options['date'] }.merge(options)
          options
        )
        Request.get(url)
      end
    end
  end
end