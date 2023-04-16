# frozen_string_literal: true

module AwesomeChatgptActors
  # This class is the implementation of Awesome Chatgpt Prompts with improvements
  class Actor
    def initialize(role: "Virtual Assistant", prompt: nil,  language: "en",  random: false,
                    has_placeholder: false, accertivity: 1, default_frequency: 0, default_presence: 0)          
      @csv_path = CastControl.csv_path if language == "en"
      @csv_path = CastControl.csv_path.gsub("en", language) if language != "en"
      @language = language || "en"
      @actors_csv = CSV.read(@csv_path, headers: true)
      @role = role
      @prompt = prompt
      @random = random
      @accertivity = accertivity
      @default_frequency = default_frequency
      @default_presence = default_presence
      @has_placeholder = has_placeholder
      act_as(role) unless random || prompt
      act_as(random_actor) if random
    end

    attr_accessor :role, :prompt, :actors_csv, :accertivity, :default_frequency, :default_presence, :has_placeholder
    attr_reader :csv_path, :random

    def act_as(role = "Virtual Assistant")
      @role = role
      actor_row = actors_csv.select { |row| row["act"] == role }
      raise ArgumentError, "Role not found: #{role}" if actor_row.empty?
      @prompt = actor_row.sample["prompt"]
      @accertivity = actor_row.sample["accertivity"].to_i
      @default_frequency = actor_row.sample["default_frequency"].to_i
      @default_presence = actor_row.sample["default_presence"].to_i
      @has_placeholder = actor_row.sample["has_placeholder"] == "false" ? false : true
      self
    end

    protected

    attr_reader :language

    private

    def random_actor
      actor = actors_csv.map { |row| row["act"] }.sample
      raise "No actors found" if actor.nil?

      actor
    end
  end
end
