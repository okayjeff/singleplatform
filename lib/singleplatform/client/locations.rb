module Singleplatform
  class Client
    module Locations
      def location(id, options = {})
        url = generate_url("/locations/#{id}/", options)
        Request.get(url)
      end

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