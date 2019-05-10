
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tiny/record/version"

Gem::Specification.new do |spec|
  spec.name          = "tiny-record"
  spec.version       = Tiny::Record::VERSION
  spec.authors       = ["Vikas Verma"]
  spec.email         = ["vikasvr23@gmail.com"]

  spec.summary       = %q{target columns when querying for active record objects}
  spec.description   = %q{Use the with options to target your columns you want in your active record collection}
  spec.homepage      = "https://rubygems.org/gems/tiny-record"
  spec.license       = "MIT"
  spec.metadata    = { "source_code_uri" => "https://github.com/vikasvr/tiny-record" }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mysql2", '~> 0.4.0'
  spec.add_development_dependency "activerecord", "~> 4.0"
  spec.add_runtime_dependency 'activerecord', '>= 4.0'
end
