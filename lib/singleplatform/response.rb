require 'cgi'

module Singleplatform
  class Response
    attr_accessor :code, :body, :next_page, :origin

    def initialize(args)
      @code      = args[:code]
      @body      = args[:body]
      @next_page = args[:body].respond_to?(:next) ? args[:body].next : nil
      @origin    = args[:origin].to_s
    end

    # An iterator for retrieving the next page of results from
    #   API response.
    #
    # @note Will only work with Client#locations_updated_since and
    #   #photos_updated_since at this time.
    #
    # @return [Hashie::Mash]
    def next
      return nil if next_page.nil? || next_page.empty?
      params = prepare_params(next_page)
      client = Singleplatform.new(
        client_id:     ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET']
      )
      new_page = client.public_send(
                                    origin.to_sym,
                                    params.delete('date'), params
                                    )
      refresh(new_page)
    end

    private

    # Update Response instance variables
    #
    # @param [Singleplatform::Response]
    # @return [Singleplatform::Response]
    def refresh(response)
      @code      = response.code
      @body      = response.body
      @next_page = response.next_page
      response
    end

    # Take any given URL and parse its query params.
    #
    # @param url [String]
    # @return [Hash]
    def parse_params(url)
      CGI::parse(url.split('?')[-1])
    end

    # Include additional params required for accessing API
    #
    # @return [Hash]
    def prepare_params(url)
      params = parse_params(url)
      params['client'] = ENV['CLIENT_ID']
      params
    end
  end
end