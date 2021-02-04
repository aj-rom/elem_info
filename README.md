# ElemInfo

Welcome to ElemInfo! ( a.k.a Element Information )
A scraping library that is used to gather information on all known elements and let you explore details on them or even build brand new chemical compounds! Also calculates the mass percentage of the chemical compound and gets basic history on any element you choose to inspect.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elem_info'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elem_info

## Usage

To use the CLI, simply run `bin/elem_info` and follow the prompts to explore or create new chemical compounds.

To use the API, ensure that you load all of the elements by calling `ElemInfo::Scraper.load_elements` to load the list of elements.
To get deeper information on an element call `ElemInfo::Scraper.add_description(element)` to load some basic summary on the element.
The `ElemInfo::Element` class has many filtering and grouping methods to get elements by, or to sort them feel free to experiment with them.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/elem_info` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'coachluck'/elem_info. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ElemInfo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'coachluck'/elem_info/blob/master/CODE_OF_CONDUCT.md).
