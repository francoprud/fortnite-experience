# FortniteExperience

[![Gem Version](https://badge.fury.io/rb/fortnite_experience.svg)](https://badge.fury.io/rb/fortnite_experience)

This gem provides a class to group the total experience of the current Fortnite season weekly challenges by Point Of Interest (POI). It uses [FortniteApi.io](https://fortniteapi.io/) API to retrieve the information about POIs and weekly challenges.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fortnite_experience'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fortnite_experience

## Usage

To use this gem, you need to be registered at [FortniteApi.io](https://fortniteapi.io/) and have a developer key (`FORTNITE_API_IO_KEY`).

```ruby
require 'fortnite_experience'

# Initialize with a valid FortniteApi.io key
fortnite_calculator = FortniteExperience::Calculator.new('FORTNITE_API_IO_KEY')
fortnite_calculator.experience_by_pois #=> { 'CRAGGY CLIFFS' => 50_000, 'CATTY CORNER' => 25_000 }

# Initialize with an invalid FortniteApi.io key
fortnite_calculator = FortniteExperience::Calculator.new('INVALID_KEY')
fortnite_calculator.experience_by_pois #=> *** FortniteExperience::Services::FortniteAPI::APIKeyNotValidError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/francoprud/fortnite_experience. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/francoprud/fortnite_experience/blob/master/CODE_OF_CONDUCT.md).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rubocop (`bundle exec rubocop Gemfile lib spec`)
5. Run rspec (`bundle exec rspec`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FortniteExperience project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fortnite_experience/blob/master/CODE_OF_CONDUCT.md).
