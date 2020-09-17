require_relative 'lib/fortnite_experience/version'

Gem::Specification.new do |spec|
  spec.name          = 'fortnite_experience'
  spec.version       = FortniteExperience::VERSION
  spec.authors       = ['prudi']

  spec.summary       = 'Gem that groups by POIs the amount of experience from weekly challenges.'
  spec.description   = 'Groups POIs with the xp points from weekly challenges. Use FortniteAPI.io.'
  spec.homepage      = 'https://github.com/francoprud/fortnite_experience'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/francoprud/fortnite_experience'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 11.2', '>= 11.2.2'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.42.0'

  spec.add_runtime_dependency 'httparty', '~> 0.13.7'
end
