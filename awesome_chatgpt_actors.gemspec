# frozen_string_literal: true

require_relative "lib/awesome_chatgpt_actors/version"

Gem::Specification.new do |spec|
  spec.name = "awesome_chatgpt_actors"
  spec.version = AwesomeChatgptActors::VERSION
  spec.authors = ["JesusGautamah"]
  spec.email = ["lima.jesuscc@gmail.com"]

  spec.summary = "This gem is the implementation of Awesome Chatgpt Prompts with improvements"
  spec.description = "With Awesome Chatgpt Actors you can easily build an actor context for your chatbot"
  spec.homepage = "https://github.com/JesusGautamah/awesome-chatgpt-actors"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "csv", "~> 3.1"
  spec.metadata["rubygems_mfa_required"] = "true"
end
