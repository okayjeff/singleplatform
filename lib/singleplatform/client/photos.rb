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
        url = generate_url("/location/#{id}/photos", options)
        Request.get(url)
      end

      # Fetch photos added/updated since a given date
      #
      # @param date [String]
      # @return [Hashie::Mash]
      def photos_updated_since(date)
        url = generate_url('/photos/updated_since/', date: date)
        Request.get(url)
      end
    end
  end
end