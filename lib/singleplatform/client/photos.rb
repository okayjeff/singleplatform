module Singleplatform
  class Client
    module Photos
      # Fetch photos for a given location
      #
      # @param date [String]
      # @param options [Hash]
      # @option options [Fixnum] :height
      # @option options [Fixnum] :width
      # @option options [String] :type (interior, exterior, item, logo, uncategorized)
      # @return [Hashie::Mash]
      def photos_for(id, options = {})
        raise Error::InvalidLocationError unless valid_params?(id)
        url = generate_url("/location/#{id}/photos", options)
        Request.get(url)
      end

      # Fetch photos added/updated since a given date
      #
      # @param date [String]
      # @param options [Hash]
      # @option options [Fixnum] :limit Maximum (default) 5000 per page
      # @return [Hashie::Mash]
      def photos_updated_since(date, options = {})
        raise Error::InvalidDateError unless valid_params?(date)
        url = generate_url(
          '/photos/updated_since/',
          { date: date }.merge(options)
        )
        Request.get(url)
      end
    end
  end
end