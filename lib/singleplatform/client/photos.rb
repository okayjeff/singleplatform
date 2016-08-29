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
      def photos_for(id, date, options = {})
        url = generate_url(
          "/location/#{id}/photos",
          { date: date }.merge(options)
        )
        Request.get(url)
      end
    end
  end
end