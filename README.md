actionpack-xml\_parser
======================

A XML parameters parser for Action Pack (removed from core in Rails 4.0)

Installation
------------

Include this gem into your Gemfile:

```ruby
gem 'actionpack-xml_parser'
```

Then, add `ActionDispatch::XmlParamsParser` middleware after `ActionDispatch::ParamsParser`
in `config/application.rb`:

```ruby
config.middleware.insert_after ActionDispatch::ParamsParser, ActionDispatch::XmlParamsParser
```

You may need to require the `ActionDispatch::XmlParamsParser` manually. Add the following 
in your `config/application.rb`:

```ruby
require 'action_dispatch/xml_params_parser'
```

Params parsing rules
--------------------

### Hashes

Request:
```xml
<person><name>David</name></person>
```

Resulting params:
```ruby
{"person" => {"name" => "David"}}
```

### Single file

Request:
```xml
<person>
  <name>David</name>
  <avatar type='file' name='me.jpg' content_type='image/jpg'>#{::Base64.encode64('ABC')}</avatar>
</person>
```

Resulting params:
```
{"person" => {"name" => "David", "avatar" => #<ActionDispatch::Http::UploadedFile:...>}}
```

### Multiple files

Request:
```xml
<person>
  <name>David</name>
  <avatars>
    <avatar type='file' name='me.jpg' content_type='image/jpg'>#{::Base64.encode64('ABC')}</avatar>
    <avatar type='file' name='me_riding_cool_car.jpg' content_type='image/jpg'>#{::Base64.encode64('DEF')}</avatar>
  </avatars>
</person>
```

Resulting params:
```
{"person" => {"name" => "David", "avatars" => [#<ActionDispatch::Http::UploadedFile:...>, #<ActionDispatch::Http::UploadedFile:...>]}}
```

### Arrays

There are several ways to pass an array.

Prefered:
```xml
<contract>
  <discount_levels type="array">
    <level min_total="42000" discount="22"/>
    <level nil="true"/>
  </discount_levels>
</contract>
```

Result:
```ruby
{"contract" => {"discount_levels" => [{"min_total"=>"42000", "discount"=>"22"}]}}
```



