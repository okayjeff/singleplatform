module Singleplatform
  class Client
    module Photos
      def photos_for(id, date = {}, options = {})
        url = generate_url("/location/#{id}/photos", date.merge(options))
        Request.get(url)
      end
    end
  end
end