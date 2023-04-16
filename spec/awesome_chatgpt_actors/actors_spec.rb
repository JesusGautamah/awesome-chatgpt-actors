# frozen_string_literal: true

RSpec.describe AwesomeChatgptActors::Actor do
  let(:csv_file) { "prompts-data/awesome-en-prompts.csv" }
  let(:role) { "Linux Terminal" }
  let(:default_role) { "Virtual Assistant" }
  let(:default_actor) { AwesomeChatgptActors::Actor.new }
  let(:random_actor) { AwesomeChatgptActors::Actor.new(random: true) }
  let(:actor) { AwesomeChatgptActors::Actor.new(role: role) }
  let(:portuguese_actor) { AwesomeChatgptActors::Actor.new(role: default_role, language: "pt") }
  let(:prompt) { CSV.read(csv_file, headers: true).select { |row| row["act"] == role }.sample["prompt"] }
  let(:default_prompt) do
    CSV.read(csv_file, headers: true)
       .select { |row| row["act"] == default_role }.sample["prompt"]
  end
  it "return the prompt to act as" do
    expect(actor.act_as(role).prompt).to eq prompt
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
    has_to_include = "Eu quero que você atue como um assistente virtual"
    expect(portuguese_actor.prompt).to include has_to_include
  end

  it "return the right prompt to act as in a different language" do
    has_to_include = "Eu quero que você atue como um terminal Linux"
    expect(portuguese_actor.act_as(role).prompt).to include has_to_include
  end

  it "has a has_placeholder boolean" do
    expect(default_actor.has_placeholder).to eq false
    expect(portuguese_actor.has_placeholder).to eq false
  end

  it "has a default accertivity" do
    expect(default_actor.accertivity).to eq 1
  end

  it "has a default frequency" do
    expect(default_actor.default_frequency).to eq 0
  end

  it "has a default presence" do
    expect(default_actor.default_presence).to eq 0
  end

  it "it returns an error if the prompt type is not found" do
    expect { actor.act_as("Not Found") }.to raise_error(ArgumentError)
  end
end
