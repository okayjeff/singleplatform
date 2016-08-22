module Singleplatform
  class Client
    module Menus
      # Fetch all menus for a given location
      #
      # @param id [String]
      # @param options [Hash] :format Short menu ('short') available
      # @return [Hash]
      def menus_for(id, options = {})
        url = generate_url("/locations/#{id}/menus", options)
        Request.get(url)
      end    
    end
  end
end