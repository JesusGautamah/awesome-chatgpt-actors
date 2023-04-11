# frozen_string_literal: true

namespace :chatgpt_actors do
  desc "Copy $GEM/prompts-data/awesome-chatgpt-prompts.csv to ./prompts-data/awesome-chatgpt-prompts.csv"
  task :install do
    path = Gem::Specification.find_by_name("awesome_chatgpt_actors") # rubocop:disable Style/StringConcatenation
                             .gem_dir + "/prompts-data/awesome-chatgpt-prompts.csv"
    raise "File not found: #{path}" unless File.exist?(path)
    raise "File already exists: prompts-data/awesome-chatgpt-prompts.csv" if File.exist?("prompts-data/awesome-chatgpt-prompts.csv")

    FileUtils.mkdir_p("prompts-data") unless Dir.exist?("prompts-data")
    FileUtils.cp(path, "prompts-data/awesome-chatgpt-prompts.csv")
    puts "Installed prompts-data/awesome-chatgpt-prompts.csv"
  end
end
