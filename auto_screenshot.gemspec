# -*- encoding: utf-8 -*-
require File.expand_path('../lib/auto_screenshot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Wold"]
  gem.email         = ["wold@afomi.com"]
  gem.description   = %q{'Automatically screenshot webpages'}
  gem.summary       = %q{'Automating webpage screenshots'}
  gem.homepage      = "http://github.com/afomi/auto_screenshot"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "auto_screenshot"
  gem.require_paths = ["lib"]
  gem.version       = AutoScreenshot::VERSION
  gem.add_runtime_dependency 'capybara'
end
