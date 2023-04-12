# frozen_string_literal: true

module AwesomeChatgptActors
  # This class is the implementation of Awesome Chatgpt Prompts with improvements
  class Actor
    def initialize(prompt_type: "Virtual Assistant", language: "en", openai_api_key: nil, random: false)
      @csv_path = CastControl.csv_path
      @language = language || "en"
      @openai_api_key = openai_api_key if openai_api_key
      @actors_csv = CSV.read(@csv_path, headers: true)
      @actor = prompt_type
      act_as(prompt_type) unless random
      act_as(random_actor) if random
    end

    attr_accessor :actor, :prompt, :actors_csv
    attr_reader :csv_path

    def act_as(prompt_type = "Virtual Assistant")
      @actor = prompt_type
      actor_row = actors_csv.select { |row| row["act"] == actor }
      raise ArgumentError, "Actor type not found: #{actor}" if actor_row.empty?

      @prompt = actor_row.sample["prompt"]
      self
    end

    def with_language(lang)
      raise "No actor initialized" if prompt.nil?
      raise "No language provided" if lang.nil?

      @prompt = translate_prompt(text: prompt, language: lang)
      self
    end

    protected

    attr_reader :language

    def openai_api_key
      @openai_api_key ||= ENV.fetch("OPENAI_API_KEY", nil)
    end

    private

    def random_actor
      actor = actors_csv.map { |row| row["act"] }.sample
      raise "No actors found" if actor.nil?

      actor
    end

    def translate_prompt(text: nil, language: nil)
      text = "Translate the following text from English to #{language}: \n\n#{text}\n\n"
      client = OpenAI::Client.new(access_token: openai_api_key)
      response = client.completions(
        parameters: {
          model: "text-davinci-003", prompt: text,
          temperature: 0.1, max_tokens: 200,
          top_p: 1, frequency_penalty: 0,
          presence_penalty: 0, stop: ["\n\n"]
        }
      )
      response["choices"].first["text"]
    end
  end
end
