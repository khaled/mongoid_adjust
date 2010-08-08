# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongoid_adjust}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-08-08}
  s.description = %q{Add simple adjust! method to Mongoid.}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "Rakefile",
     "VERSION",
     "lib/mongoid_adjust.rb",
     "spec/.rspec",
     "spec/mongoid_adjust_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/mongoid_adjust}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Add simple adjust! method to Mongoid}
  s.test_files = [
    "spec/mongoid_adjust_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, [">= 2.0.0.beta.14"])
      s.add_runtime_dependency(%q<bson>, [">= 1.0.3"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.15"])
    else
      s.add_dependency(%q<mongoid>, [">= 2.0.0.beta.14"])
      s.add_dependency(%q<bson>, [">= 1.0.3"])
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.15"])
    end
  else
    s.add_dependency(%q<mongoid>, [">= 2.0.0.beta.14"])
    s.add_dependency(%q<bson>, [">= 1.0.3"])
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.15"])
  end
end

