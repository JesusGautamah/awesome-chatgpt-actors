# frozen_string_literal: true

require_relative "awesome_chatgpt_actors/version"
require_relative "awesome_chatgpt_actors/actor"
require_relative "awesome_chatgpt_actors/cast_control"
require "csv"
require "openai"

# Main module
module AwesomeChatgptActors
  require "awesome_chatgpt_actors/railtie" if defined?(Rails)
end
