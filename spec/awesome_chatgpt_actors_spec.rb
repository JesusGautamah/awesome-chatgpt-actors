# frozen_string_literal: true

RSpec.describe AwesomeChatgptActors do
  it "has a version number" do
    expect(AwesomeChatgptActors::VERSION).not_to be nil
  end

  it "has a load_tasks method" do
    expect(AwesomeChatgptActors).to respond_to(:load_tasks)
  end
end
