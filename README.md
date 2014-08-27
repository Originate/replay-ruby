# ReplayApi

Send your events and traits to Replay.io from the server using Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'replay_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install replay_api

## Usage

First, configure the library with your `replay_key`. In Rails
this is best done in an initializer. Outside of Rails, it just
needs to happen before you start sending events and traits.

```ruby
ReplayApi.configure do |config|
  config.replay_key = 'xxx-xxx-xxx-xxx'
end
```

You may opt to create a globally accessible instance of the client
or you can create a new one for each event. In either case, the
mechanism for sending events and traits is the same.

### Send an Event

```ruby
client = ReplayApi::Client.new
client.event do |event|
  event.event_name = 'Purchase'
  event.distinct_id = user.id
  event.properties.amount = 100
end
```

### Send a Trait
```ruby
client = ReplayApi::Client.new
client.trait do |trait|
  trait.distinct_id = user.id
  trait.properties.email = user.email
end
```

### Alternative Usages

You can alternatively create a `ReplayApi::Event` or `ReplayApi::Trait`
and pass it to the `event` or `trait` method with or without a block.

```ruby
event = ReplayApi::Event.new(event_name: 'Purchase', distinct_id: user.id, properties: { amount: 100 })
client = ReplayApi::Client.new
client.event(event)
```

The `ReplayApi::Event` object has three fields, `event_name`, `distinct_id`, and `properties`.
The `ReplayApi::Trait` object has two fields, `distinct_id` and `properties`.
The `properties` by default know about all of the API Special Properties for the event or trait.

You can choose to add your own custom properties by create the definitions in the configuration block.

```ruby
ReplayApi.configure do |config|
  config.replay_key = 'xxx-xxx-xxx-xxx'
  config.extend_event_properties do |ext|
    ext.attribute :source, String
  end
  config.extend_trait_properties do |ext|
    ext.attribute :favorite_color, String
    ext.attribute :favorite_number, Integer
  end
end
```

The models use [Virtus][1] for the attributes. Any valid type supported by Virtus is available.
You can also make your own custom types for embeded objects of information.

```ruby
class SubscriptionPlan < ReplayApi::Model
  attribute :name, String
  attribute :price, 25
end

ReplayApi.configure do |config|
  config.replay_key = 'xxx-xxx-xxx-xxx'
  config.extend_trait_properties do |ext|
    ext.attribute :subscription_plan, SubscriptionPlan
  end
end
```


## Contributing

1. Fork it ( https://github.com/Originate/replay_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


  [1]: https://github.com/solnic/virtus
