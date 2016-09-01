require 'cgi'

module Singleplatform
  class Response
    attr_accessor :code, :body, :next_page

    def initialize(args)
      @code      = args[:code]
      @body      = args[:body]
      @next_page = args[:body].next
    end

    # An iterator for retrieving the next page of results from
    # API response.
    #
    # @note Will only work with Client#locations_updated_since as
    # it's the only paginated response in the API at this time.
    #
    # @return [Hashie::Mash]
    def next
      return nil if next_page.nil?
      params = prepare_params(next_page)
      client = Singleplatform.new(
        client_id:     ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET']
      )
      new_page = client.locations_updated_since(params)
      refresh(new_page)
    end

    private

    def refresh(response)
      @code      = response.code
      @body      = response.body
      @next_page = response.next_page
      response
    end

    def parse_params(url)
      CGI::parse(url.split('?')[-1])
    end

    def prepare_params(url)
      params = parse_params(url)
      params['client'] = ENV['CLIENT_ID']
      params
    end
  end
end