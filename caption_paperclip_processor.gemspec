# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caption_paperclip_processor/version'

Gem::Specification.new do |spec|
  spec.name          = "caption_paperclip_processor"
  spec.version       = CaptionPaperclipProcessor::VERSION
  spec.authors       = ["Shaun Dern"]
  spec.email         = ["shaun@substantial.com"]
  spec.description   = %q{Add captions to images}
  spec.summary       = %q{Add captions to images}
  spec.homepage      = "https://github.com/substantial/caption_paperclip_processor"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "paperclip", "~> 3.4.0"
end

