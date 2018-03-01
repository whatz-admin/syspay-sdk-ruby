
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'syspay-sdk/version'

Gem::Specification.new do |gem|
  gem.name          = 'syspay-sdk'
  gem.version       = SyspaySDK::VERSION
  gem.authors       = ['Fabien Anthonioz']
  gem.email         = ['fabien.anthonioz@neteden.fr']
  gem.summary       = 'The Syspay SDK provides Ruby APIs to create, process and manage payments and subscriptions.'
  gem.description   = 'The Syspay SDK provides Ruby APIs to create, process and manage payments and subscriptions.'
  gem.homepage      = 'https://app.syspay.com/'

  gem.files         = Dir['{spec,lib}/**/*'] + ['Rakefile', 'README.md', 'Gemfile']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
