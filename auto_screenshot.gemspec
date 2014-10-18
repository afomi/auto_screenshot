#encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auto_screenshot/version'

Gem::Specification.new do |gem|
  gem.name          = "auto_screenshot"
  gem.version       = AutoScreenshot::VERSION
  gem.authors       = ["Ryan Wold"]
  gem.email         = ["wold@afomi.com"]
  gem.description   = %q{'Automatically screenshot webpages'}
  gem.summary       = %q{'Automating webpage screenshots'}
  gem.homepage      = "http://github.com/afomi/auto_screenshot"

  gem.files         = 'git ls-files'.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capybara"
  gem.add_dependency "json"
  gem.add_dependency "nokogiri"
  gem.add_dependency "selenium-webdriver"
  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
