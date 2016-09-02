module Singleplatform
  class Client
    module Menus
      # Fetch all menus for a given location
      #
      # @param id [String]
      # @param options [Hash]
      # @option options [String] :format Short menu available ('short')
      # @return [Hashie::Mash]
      def menus_for(id, options = {})
        raise Error::InvalidLocationError unless valid_params?(id)
        url = generate_url("/locations/#{id}/menus", options)
        Request.get(url)
      end    
    end
  end
end