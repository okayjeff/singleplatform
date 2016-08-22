module Singleplatform
  class Client
    module Menus
      def menus(id, options = {})
        url = generate_url("/locations/#{id}/menus", options)
        Request.get(url)
      end    
    end
  end
end