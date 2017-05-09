$:.push File.expand_path("../lib", __FILE__)
require "action_pack/xml_parser/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'actionpack-xml_parser'
  s.version     = ActionPack::XmlParser::VERSION
  s.summary     = 'XML parameters parser for Action Pack (removed from core in Rails 4.0)'

  s.required_ruby_version = '>= 2.2.2'
  s.license     = 'MIT'

  s.author      = 'Prem Sichanugrist'
  s.email       = 's@sikac.hu'
  s.homepage    = 'http://www.rubyonrails.org'

  s.files        = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.require_path = 'lib'

  s.extra_rdoc_files = %w( README.md )
  s.rdoc_options.concat ['--main',  'README.md']

  s.add_dependency('actionpack', '>= 5.0')
  s.add_dependency('railties', '>= 5.0')

  s.add_development_dependency('rake')
end
