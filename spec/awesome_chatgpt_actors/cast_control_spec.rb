# frozen_string_literal: true

RSpec.describe AwesomeChatgptActors::CastControl do
  let(:role) { "Linux Terminal" }
  let(:default_type) { "Virtual Assistant" }

  it "return the list of actors" do
    expect(AwesomeChatgptActors::CastControl.actors).to be_a Array
    expect(AwesomeChatgptActors::CastControl.actors).not_to be_empty
    expect(AwesomeChatgptActors::CastControl.actors).to include role
    expect(AwesomeChatgptActors::CastControl.actors).to include default_type
  end

  it "has csv pt_csv and temp csv paths" do
    expect(AwesomeChatgptActors::CastControl.csv_path).to be_a String
    expect(AwesomeChatgptActors::CastControl.pt_csv_path).to be_a String
    expect(AwesomeChatgptActors::CastControl.temp_path).to be_a String
  end

  it "add a new actor" do
    actors_size = AwesomeChatgptActors::CastControl.actors.size
    expect(AwesomeChatgptActors::CastControl.actors).not_to include "New Actor"
    AwesomeChatgptActors::CastControl.add_actor(actor: "New Actor", prompt: "New Prompt")
    expect(AwesomeChatgptActors::CastControl.actors).to include "New Actor"
    expect(AwesomeChatgptActors::CastControl.actors.size).to eq actors_size + 1
  end

  it "add a new actor in pt" do
    actors_size = AwesomeChatgptActors::CastControl.actors_pt.size
    expect(AwesomeChatgptActors::CastControl.actors_pt).not_to include "Novo Ator"
    AwesomeChatgptActors::CastControl.add_actor(actor: "Novo Ator", prompt: "Novo Prompt", language: "pt")
    expect(AwesomeChatgptActors::CastControl.actors_pt).to include "Novo Ator"
    expect(AwesomeChatgptActors::CastControl.actors_pt.size).to eq actors_size + 1
  end

  it "remove an actor" do
    unless AwesomeChatgptActors::CastControl.actors.include? "New Actor"
      actor.add_actor(actor: "New Actor",
                      prompt: "New Prompt")
    end
    actors_list_row = AwesomeChatgptActors::CastControl.actors.size
    AwesomeChatgptActors::CastControl.remove_actor(actor: "New Actor")
    expect(AwesomeChatgptActors::CastControl.actors.size).to eq actors_list_row - 1
  end

  it "remove an actor in pt" do
    unless AwesomeChatgptActors::CastControl.actors_pt.include? "Novo Ator"
      actor.add_actor(actor: "Novo Ator", prompt: "Novo Prompt",
                      language: "pt")
    end
    actors_list_row = AwesomeChatgptActors::CastControl.actors_pt.size
    AwesomeChatgptActors::CastControl.remove_actor(actor: "Novo Ator", language: "pt")
    expect(AwesomeChatgptActors::CastControl.actors_pt.size).to eq actors_list_row - 1
  end
end
