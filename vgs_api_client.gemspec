# -*- encoding: utf-8 -*-

require_relative "lib/version"

Gem::Specification.new do |s|
  s.name        = "vgs_api_client"
  s.version     = VGS::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Very Good Security"]
  s.email       = ["support@verygoodsecurity.com"]
  s.homepage    = "https://github.com/verygoodsecurity/vgs-api-client-ruby"
  s.summary     = "VGS API Client"
  s.description = "This gem maps to VGS Vault API"
  s.license     = "BSD-3-Clause"
  s.required_ruby_version = ">= 2.6"

  s.metadata = {
    "homepage_uri"      => "https://www.verygoodsecurity.com",
    "bug_tracker_uri"   => "https://github.com/verygoodsecurity/vgs-api-client-ruby/issues",
    "documentation_uri" => "https://www.verygoodsecurity.com/docs",
    "source_code_uri"   => "https://github.com/verygoodsecurity/vgs-api-client-ruby"
  }

  s.add_runtime_dependency 'typhoeus', '~> 1.0', '>= 1.0.1'

  s.add_development_dependency 'rspec', '~> 3.6', '>= 3.6.0'

  s.files         = `find *`.split("\n").uniq.sort.select { |f| !f.empty? }
  s.test_files    = `find spec/*`.split("\n")
  s.executables   = []
  s.require_paths = ["lib"]
end
