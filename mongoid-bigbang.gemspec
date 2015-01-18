# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/bigbang/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-bigbang"
  spec.version       = Mongoid::Bigbang::VERSION
  spec.authors       = ["Daniel Serrano"]
  spec.email         = ["danieljdserrano@gmail.com"]
  spec.summary       = %q{Mock creation times through Moped::BSON::ObjectId.}
  spec.description   = %q{
    When you have a project in which you are not using Mongoid::Timestamps and you want to \
    mock an object's creation time, you have to do some cumbersome operations in order to get those first 4 bytes \
    of the ObjectId to represent the seconds since the Unix epoch that you want for that object. \
    Particularly, if you want to have two objects with the same creation time, it would not suffice to generate \
    the IDs via the BSON::ObjectId.from_time method, since it would yield the same ID for \
    both objects, and you probably do not want them to be seen as the same object. \
    This gem solves this little annoying issue by generating a unique ID for the given timestamp \
    by using the other 8 bytes in ObjectId to generate the needed additional entropy.
  }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "pry-byebug", "~> 2.0.0"

  spec.add_dependency "moped", "~> 2.0.0"
end
