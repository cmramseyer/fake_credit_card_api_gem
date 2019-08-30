$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "fake_credit_card_api_gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "fake_credit_card_api_gem"
  spec.version     = FakeCreditCardApiGem::VERSION
  spec.authors     = ["Carlos Ramseyer"]
  spec.email       = ["carlos@bytelion.com"]
  spec.homepage    = "https://github.com/cmramseyer"
  spec.summary     = "An example gem to communicate with Fake Credit Card API"
  spec.description = "Used for Shop Demo app"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "json"
  spec.add_dependency "httparty"

end
