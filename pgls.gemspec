lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pgls/version"

Gem::Specification.new do |spec|
  spec.name          = "pgls"
  spec.version       = PgLdapSync::VERSION
  spec.authors       = ["fruworg"]
  spec.email         = ["im@fruw.org"]

  spec.summary       = %q{Use LDAP permissions in PostgreSQL}
  spec.homepage      = "https://github.com/fruworg/pgls"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.rdoc_options = %w[--main README.md --charset=UTF-8]
  spec.required_ruby_version = ">= 2.3"

  spec.add_runtime_dependency "net-ldap", "~> 0.16"
  spec.add_runtime_dependency "kwalify", "~> 0.7"
  spec.add_runtime_dependency "pg", ">= 0.14", "< 2.0"
  spec.add_runtime_dependency "net-ldap-auth_adapter-gssapi", "~> 0.2.0"
  spec.add_development_dependency "ruby-ldapserver", "~> 0.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "bundler", ">= 1.16", "< 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest-hooks", "~> 1.4"
end
