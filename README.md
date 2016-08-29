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

#### Fetching Locations by ID

```ruby
client.location('nobu')
```

This will return a Hashie::Mash pseudo object, which allows you to access attributes on the response using dot notation. Nested attributes continue to return Hashie::Mash objects until there are no children.

```ruby
location = client.location('nobu') # => #<Hashie::Mash ... >
location.name                      # => "Nobu"
location.attributes                # => #<Hashie::Mash ... >
location.attributes.drive_thru     # => false
```

See SinglePlatform's API documentation for a full list of attributes.

#### Fetching Locations Updated Since a Given Date

You can retrieve locations en masse by calling:

```ruby
client.locations_updated_since('2016-08-01', limit: 100)
```

Results are paginated. The maximum (and default) limit per page is 5000.

### Menus
SinglePlatform locations have menus or lists of products and services that you can access with a configured API client. The following call returns an Array of Hashie::Mash objects.

```ruby
menus = client.menus_for('nobu') # => #<Array ... >
menus.first.name                 # => "Dinner Menu"
```

See SinglePlatform's API documentation for the Menu schema with a full list of attributes.

### Photos
Many SinglePlatform locations have photos, both at the business and menu-item level. Returns an Array of Hashie::Mash objects.

```ruby
photos = client.photos_for('no') # => #<Array ... >
photos.first.type                # => "Product"
photos.first.url                 # => "http://xyz.cloudfront.net/.../39bf7671bc7d006f4cef72d94eee24aeec7615d2.jpg"
```

