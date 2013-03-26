# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backup2sndacs/version'

Gem::Specification.new do |gem|
  gem.name          = "backup2sndacs"
  gem.version       = Backup2sndacs::VERSION
  gem.authors       = ["LI Daobing"]
  gem.email         = ["lidaobing@gmail.com"]
  gem.description   = %q{backup to http://www.grandcloud.cn/product/ecs}
  gem.summary       = %q{backup to http://www.grandcloud.cn/product/ecs}
  gem.homepage      = "https://github.com/lidaobing/backup2sndacs"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'backup', '~> 3.1.0'
  gem.add_dependency 'sndacs', '~> 0.2.0'
end
