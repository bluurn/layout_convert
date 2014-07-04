# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'layout_convert/version'

Gem::Specification.new do |spec|
  spec.name          = "layout_convert"
  spec.version       = LayoutConvert::VERSION
  spec.authors       = ["bluurn"]
  spec.email         = ["bluurn@gmail.com"]
  spec.summary       = %q{Basic string Latin <-> Cyrillic Layour swapper }
  spec.description   = %q{
A String class now has these methods available
* cyrillic?
* latin?
* mixed?
* cyrillish?
* latinish?
* swap_layout
Usage: It's simple, just type
```
"ghbdtn".swap_layout
```
And you will get this result
```
=> "привет"
```
Easy! :)
}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
