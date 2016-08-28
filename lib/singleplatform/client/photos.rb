module Singleplatform
  class Client
    module Photos
      # Fetch photos for a given location
      #
      # @param date [String]
      # @param options [Hash] :height, :width, :type
      # @see http://docs.singleplatform.com/spv3/publisher_api
      # @return [Hash]
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