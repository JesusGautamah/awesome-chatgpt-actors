# frozen_string_literal: true

require_relative "awesome_chatgpt_actors/version"
require_relative "awesome_chatgpt_actors/actor"
require_relative "awesome_chatgpt_actors/cast_control"
require "csv"
require "openai"

# Main module
module AwesomeChatgptActors
  require "awesome_chatgpt_actors/railtie" if defined?(Rails)

  class << self
    def load_tasks
      Dir[File.join(__dir__, "tasks", "*.rake")].each { |r| load r }
    end
  end
end
