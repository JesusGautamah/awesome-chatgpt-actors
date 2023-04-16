# frozen_string_literal: true

namespace :chatgpt_actors do
  desc "Copy $GEM/prompts-data/awesome-language-prompts.csv to ./prompts-data/awesome-language-prompts.csv"
  task :install do
    en_path = Gem::Specification.find_by_name("awesome_chatgpt_actors")
                             .gem_dir + "/prompts-data/awesome-en-prompts.csv"
    pt_path = Gem::Specification.find_by_name("awesome_chatgpt_actors")
                              .gem_dir + "/prompts-data/awesome-pt-prompts.csv"
    paths = [en_path, pt_path]
    raise "File not found: #{paths[0]}" unless File.exist?(paths[0])
    raise "File not found: #{paths[1]}" unless File.exist?(paths[1])

    FileUtils.mkdir_p("prompts-data") unless Dir.exist?("prompts-data")

    FileUtils.cp(paths[0], "prompts-data/awesome-en-prompts.csv")
    puts "Installed prompts-data/awesome-en-prompts.csv"

    FileUtils.cp(paths[1], "prompts-data/awesome-pt-prompts.csv")
    puts "Installed prompts-data/awesome-pt-prompts.csv"
    puts "You can contribute to the project adding more actors and prompts or languages at"
    puts "https://github.com/JesusGautamah/awesome_chatgpt_actors"
  end
end
