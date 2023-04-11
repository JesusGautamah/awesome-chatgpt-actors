# frozen_string_literal: true

RSpec.describe AwesomeChatgptActors::Actor do
  let(:csv_file) { "data/awesome-chatgpt-prompts.csv" }
  let(:prompt_type) { "Linux Terminal" }
  let(:default_type) { "Virtual Assistant" }
  let(:default_actor) { AwesomeChatgptActors::Actor.new }
  let(:random_actor) { AwesomeChatgptActors::Actor.new(random: true) }
  let(:actor) { AwesomeChatgptActors::Actor.new(prompt_type: prompt_type) }
  let(:portuguese_actor) { AwesomeChatgptActors::Actor.new(prompt_type: prompt_type, language: "pt") }
  let(:prompt) { CSV.read(csv_file, headers: true).select { |row| row["act"] == prompt_type }.sample["prompt"] }
  let(:default_prompt) do
    CSV.read(csv_file, headers: true)
       .select { |row| row["act"] == default_type }.sample["prompt"]
  end
  it "return the prompt to act as" do
    expect(actor.act_as(prompt_type).prompt).to eq prompt
  end

  it "return the default prompt to act as" do
    expect(actor.act_as.prompt).to eq default_prompt
  end

  it "return a random prompt to act as" do
    expect(random_actor.prompt).to_not eq default_prompt
    expect(random_actor.prompt).to be_a String
    expect(random_actor.prompt).to_not be_empty
  end

  it "have the default prompt if act_as was not called" do
    expect(default_actor.prompt).to eq default_prompt
  end

  it "return the prompt to act as in a different language" do
    has_to_include = "Quero que você atue como um assistente virtual"
    expect(portuguese_actor.act_as.with_language("pt").prompt).to include has_to_include
    has_to_include = "Quiero que actúes como un asistente virtual"
    expect(portuguese_actor.act_as.with_language("es").prompt).to include has_to_include
  end

  it "it returns an error if the prompt type is not found" do
    expect { actor.act_as("Not Found") }.to raise_error(ArgumentError)
  end
end
