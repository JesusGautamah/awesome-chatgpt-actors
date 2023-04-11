# frozen_string_literal: true

RSpec.describe AwesomeChatgptActors::CastControl do
  let(:prompt_type) { "Linux Terminal" }
  let(:default_type) { "Virtual Assistant" }


  it "return the list of actors" do
    expect(AwesomeChatgptActors::CastControl.actors).to be_a Array
    expect(AwesomeChatgptActors::CastControl.actors).not_to be_empty
    expect(AwesomeChatgptActors::CastControl.actors).to include prompt_type
    expect(AwesomeChatgptActors::CastControl.actors).to include default_type
  end

  it "add a new actor" do
    actors_size = AwesomeChatgptActors::CastControl.actors.size
    expect(AwesomeChatgptActors::CastControl.actors).not_to include "New Actor"
    AwesomeChatgptActors::CastControl.add_actor(actor: "New Actor", prompt: "New Prompt")
    expect(AwesomeChatgptActors::CastControl.actors).to include "New Actor"
    expect(AwesomeChatgptActors::CastControl.actors.size).to eq actors_size + 1
  end

  it "remove an actor" do
    actor.add_actor(actor: "New Actor", prompt: "New Prompt") unless AwesomeChatgptActors::CastControl.actors.include? "New Actor"
    actors_list_row = AwesomeChatgptActors::CastControl.actors.size
    AwesomeChatgptActors::CastControl.remove_actor(actor: "New Actor")
    expect(AwesomeChatgptActors::CastControl.actors.size).to eq actors_list_row - 1
  end
end
