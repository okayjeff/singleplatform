# SinglePlatform API Ruby Client
This is a wrapper for accessing SinglePlatform's API. Please see [SinglePlatform's official API documentation](http://docs.singleplatform.com/spv3/) for information on obtaining API credentials.

## Installation
```
gem install singleplatform
```

Or add this to your applications Gemfile:
```
gem 'singleplatform'
```

And then run:

```
bundle install
```

## Usage
### Initializing an API Client
The gem uses a client model to query against the API. Create a client with your API credentials and make requests through that.

```ruby
require 'singleplatform'

client = Singleplatform.new(
  client_id:     ENV['CLIENT_ID']
  client_secret: ENV['CLIENT_SECRET']
)
```

After creating a client you're able to make requests to SinglePlatform's API. The Client ID and Client Secret are required for each request.

### Locations
With an initialized client, you can request information on locations in SinglePlatform's database.

```ruby
client.location('nobu')
```