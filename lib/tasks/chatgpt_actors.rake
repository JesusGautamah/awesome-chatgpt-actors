# frozen_string_literal: true

namespace :chatgpt_actors do
  desc "Copy $GEM/data/awesome-chatgpt-prompts.csv to ./data/awesome-chatgpt-prompts.csv"
  task :install do
    path = Gem::Specification.find_by_name("awesome_chatgpt_actors").gem_dir + "/data/awesome-chatgpt-prompts.csv"
    raise "File not found: #{path}" unless File.exist?(path)
    raise "File already exists: data/awesome-chatgpt-prompts.csv" if File.exist?("data/awesome-chatgpt-prompts.csv")

    FileUtils.mkdir_p("data") unless Dir.exist?("data")
    FileUtils.cp(path, "data/awesome-chatgpt-prompts.csv")
  end
end
