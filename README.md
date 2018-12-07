# Rekkyo

[![Build Status](https://travis-ci.org/yujideveloper/rekkyo.svg?branch=master)](https://travis-ci.org/yujideveloper/rekkyo)
[![Maintainability](https://api.codeclimate.com/v1/badges/37d6334cedf5b04af831/maintainability)](https://codeclimate.com/github/yujideveloper/rekkyo/maintainability)

Rekkyo is a gem for defining an enumerated type in Ruby.

This gem is inspired by [`Ruby::Enum`](https://github.com/dblock/ruby-enum) and [`Enum`](https://github.com/LIQIDTechnology/enum_class).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rekkyo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rekkyo

## Usage

### Basic usage

``` ruby
class Color
  include Rekkyo::Type

  member :RED
  member :GREEN
  member :BLUE
end

```

### Custom value

``` ruby
class Color
  include Rekkyo::Type

  member :RED,   "#FF0000"
  member :GREEN, "#00FF00"
  member :BLUE,  "#0000FF"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yujideveloper/rekkyo.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
