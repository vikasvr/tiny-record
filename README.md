[![Build Status](https://travis-ci.com/vikasvr/tiny-record.svg?branch=master)](https://travis-ci.com/vikasvr/tiny-record)
[![Gem Version](https://badge.fury.io/rb/tiny-record.svg)](https://badge.fury.io/rb/tiny-record)

# TinyRecord

TinyRecord gives to you the capability to target columns when you try to look for active record objects specifying the columns you want to use.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tiny-record'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiny-record

## Usage
  Suppose you have a user active record class
```ruby
  class User < ApplicationRecord
    include TinyRecord
  end
```
  Add TinyRecord module. Now you can query it using fetch method by specifying columns with "with" option and specifying the array of columns to want to use.
```ruby
  User.fetch(1, with: [:id, :first_name])
```
  It will raise active record not found error when record is not found just like rails find method.
  `fetch` and `fetch_by` methods are extension to rails find and find_by method with `with` option

  So you can also use fetch_by method by:
```ruby
  User.fetch_by(first_name: "John", with: [:id, :first_name])
```
  Just like rails find_by, it will return nil when record not found.

  You can also set defaults by:
```ruby
  class User < ApplicationRecord
    include TinyRecord
    tiny_columns :id, :first_name
  end
```
  Now whenever you use fetch or fetch by method record will be returned with these default columns.
  You can override these defaults by specifying the columns.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vikasvr/tiny-record. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tiny::Record project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/vikasvr/tiny-record/blob/master/CODE_OF_CONDUCT.md).
