# Mongoid::Bigbang

> They say it all started out with a big bang. But, what I wonder is, was it a big bang or did it just seem big because there wasn't anything else drown it out at the time?
> - Karl Pilkington

## Why?

When you have a project in which you are not using `Mongoid::Timestamps` and you want to mock an object's creation time, you have to do some cumbersome operations in order to get those first 4 bytes of the `ObjectId` to represent the seconds since the Unix epoch that you want for that object.

Particularly, if you want to have two objects with the same creation time, it would not suffice to generate the IDs via the `BSON::ObjectId.from_time` method, since it would yield the same ID for both objects, and you probably do not want them to be seen as the same object.

This gem solves this little annoying issue by generating a unique ID for the given timestamp by using the other 8 bytes in `ObjectId` to generate the needed additional entropy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid-bigbang'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-bigbang

## Usage

Whenever you want to generate a new `ObjectId` for a given timestamp, just call the `Mongoid::Bigbang.id_from_time` method, like follows:

```ruby
# from time as String
Mongoid::Bigbang.id_from_time('18-01-2015 15:53:00 +0000')

# from time as Integer
Mongoid::Bigbang.id_from_time(1421596380)

# from time as Time
time = Time.parse('18-01-2015 15:53:00 +0000')
Mongoid::Bigbang.id_from_time(time)
```

It is recommended that you add the following to your `spec_helper`:

```ruby
RSpec.configure do |config|
  config.before(:each) do
    Mongoid::Bigbang.clean
  end

  # your other configs...
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mongoid-bigbang/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
