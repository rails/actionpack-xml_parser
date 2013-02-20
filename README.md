actionpack-xml\_parser
======================

A XML parameters parser for Action Pack (removed from core in Rails 4.0)

Installation
------------

Include this gem into your Gemfile:

```ruby
gem 'actionpack-xml_parser', github: 'rails/actionpack-xml_parser'
```

Then, add `ActionDispatch::XmlParamsParser` middleware after `ActionDispatch::ParamsParser`
in `config/application.rb`:

```ruby
config.middleware.insert_after ActionDispatch::ParamsParser, ActionDispatch::XmlParamsParser
```
