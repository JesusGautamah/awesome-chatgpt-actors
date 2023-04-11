# frozen_string_literal: true

require "awesome_chatgpt_actors"
require "rails"

module AwesomeChatgptActors
  # Add the gem to the Rails application
  class Railtie < Rails::Railtie
    railtie_name :my_gem

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
