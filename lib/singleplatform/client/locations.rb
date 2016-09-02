module Singleplatform
  class Client
    module Locations
      # Fetch information about a specific location
      #
      # @param id [String]
      # @return [Singleplatform::Response]
      def location(id)
        raise Error::InvalidLocationError unless valid_params?(id)
        url = generate_url("/locations/#{id}/")
        Request.get(url)
      end

      # Fetch location, menus and photo data for a specific location
      #
      # @param id [String]
      # @return [Singleplatform::Response]
      def all_for(id)
        raise Error::InvalidLocationError unless valid_params?(id)
        url = generate_url("/locations/#{id}/all")
        Request.get(url)
      end

      # Fetch all locations updated since a given date
      #
      # @param date [String]
      # @param options [Hash]
      # @option options [Fixnum] :limit Maximum (default) 5000 per page
      # @return [Singleplatform::Response]
      def locations_updated_since(date, options = {})
        raise Error::InvalidDateError unless valid_date?(date)
        url = generate_url(
          '/locations/updated_since/',
          { date: date }.merge(options)
        )
        Request.get(url)
      end
    end
  end
end