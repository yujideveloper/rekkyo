# Rekkyo

[![Gem Version](https://badge.fury.io/rb/rekkyo.svg)](https://badge.fury.io/rb/rekkyo)
[![Build](https://github.com/yujideveloper/rekkyo/actions/workflows/ruby.yml/badge.svg)](https://github.com/yujideveloper/rekkyo/actions/workflows/ruby.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/37d6334cedf5b04af831/maintainability)](https://codeclimate.com/github/yujideveloper/rekkyo/maintainability)

Rekkyo (列挙) is a gem for defining an enumerated type in Ruby.

This gem is inspired by [`ruby-enum`](https://rubygems.org/gems/ruby-enum) and [`enum_class`](https://rubygems.org/gems/enum_class).

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

{ color: Color::RED }.to_json # => "{\"color\":\"RED\"}

Color::RED.red?   # => true
Color::BLUE.blue? # => false

Color::RED == Color::RED   # => true
Color::RED == Color::BLUE  # => false
Color::RED == :RED         # => false
Color::RED == "RED"        # => false

Color::RED === Color::RED  # => true
Color::RED === Color::BLUE # => false
Color::RED === :RED        # => true
Color::RED === "RED"       # => true

case "RED"
when Color::RED   then "#FF0000"
when Color::BLUE  then "#00FF00"
when Color::GREEN then "#0000FF"
else                   "Unkown"
end
# => "#FF0000"
```

### Custom value

``` ruby
class Color
  include Rekkyo::Type

  member :RED,   "#FF0000"
  member :GREEN, "#00FF00"
  member :BLUE,  "#0000FF"
end

Color::RED.red?   # => true
Color::BLUE.blue? # => false

{ color: Color::RED }.to_json # => "{\"color\":\"#FF0000\"}"

Color::RED == Color::RED   # => true
Color::RED == Color::BLUE  # => false
Color::RED == :"#FF0000"   # => false
Color::RED == "#FF0000"    # => false

Color::RED === Color::RED  # => true
Color::RED === Color::BLUE # => false
Color::RED === :"#FF0000"  # => true
Color::RED === "#FF0000"   # => true

case "#FF0000"
when Color::RED   then "RED"
when Color::BLUE  then "BLUE"
when Color::GREEN then "GREEN"
else                   "Unkown"
end
# => "RED"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yujideveloper/rekkyo.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
