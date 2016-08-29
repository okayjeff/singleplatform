module Singleplatform
  class Client
    module Menus
      # Fetch all menus for a given location
      #
      # @param id [String]
      # @param options [Hash]
      # @option options [String] :format Short menu available ('short')
      # @return [Hash]
      def menus_for(id, options = {})
        url = generate_url("/locations/#{id}/menus", options)
        Request.get(url)
      end    
    end
  end
end