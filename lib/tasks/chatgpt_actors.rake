# frozen_string_literal: true

namespace :chatgpt_actors do
  desc "Copy $GEM/data/awesome-chatgpt-prompts.csv to ./data/awesome-chatgpt-prompts.csv"
  task :install do
    path = File.expand_path("../../../data/awesome-chatgpt-prompts.csv", __FILE__) # rubocop:disable Style/ExpandPathArguments
    raise "File not found: #{path}" unless File.exist?(path)
    raise "File already exists: data/awesome-chatgpt-prompts.csv" if File.exist?("data/awesome-chatgpt-prompts.csv")

    FileUtils.cp(path, "data/awesome-chatgpt-prompts.csv")
  end
end
