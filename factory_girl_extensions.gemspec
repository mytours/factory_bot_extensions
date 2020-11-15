# -*- encoding: utf-8 -*-
require File.expand_path("../lib/factory_bot_extensions/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "factory_bot_extensions"
  gem.author      = "barnaclebarnes"
  gem.email       = "barnaclebarnes@mac.com"
  gem.homepage    = "http://github.com/stqry/factory_bot_extensions"
  gem.summary     = "Alternative FactoryBot API"

  gem.description = <<-desc.gsub(/^\s+/, '')
    Alternative FactoryBot API allowing you to build/generate factories 
    using your class constants, eg. User.gen instead of Factory(:user).
  desc

  files = `git ls-files`.split("\n")
  gem.files         = files
  gem.executables   = files.grep(%r{^bin/.*}).map {|f| File.basename(f) }
  gem.test_files    = files.grep(%r{^spec/.*})
  gem.require_paths = ["lib"]
  gem.version       = FactoryBotExtensions::VERSION

  gem.add_dependency "factory_bot", ">= 6.1"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "byebug"
end
