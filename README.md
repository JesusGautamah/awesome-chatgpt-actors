# AwesomeChatgptActors

This gem is a collection of actors made for use the [AwesomeChatgptPrompts](https://github.com/f/awesome-chatgpt-prompts) in ruby.
So for prompts information, please refer to that repository.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add awesome_chatgpt_actors

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install awesome_chatgpt_actors

Add to your rakefile:

    require 'awesome_chatgpt_actors'

Run in the command line:

    $ rake chatgpt_actors:install


## Usage

```ruby
require 'awesome_chatgpt_actors'

# Initialize a new actor
actor = AwesomeChatgptActors::Actor.new

# it will return an actor with the following options
# {
#   actor: 'Virtual Assistant',
#   prompt: 'I want you to act as a virtual assistant. I will give you tasks and you will reply with the results of the tasks. I want you to only reply with the results of the tasks, and nothing else. Do not write explanations. My first task is ""I want you to write a short story about a cat"""
# }

# Initialize a new actor with options
actor = AwesomeChatgptActors::Actor.new(
  actor: 'Linux Terminal', # The type of actor to use, check the list in https://github.com/f/awesome-chatgpt-prompts/blob/main/prompts.csv
  language: 'en', # The language of the prompt, if other language is specified, it will requirean openai api key to perform the translation
)

# Initialize a new actor with options
actor = AwesomeChatgptActors::Actor.new(
  language: 'pt',
  openai_api_key: 'Your OpenAI API Key' # it can be nil if you provide it as an environment variable OPENAI_API_KEY
)

# Initialize a new actor with options
actor = AwesomeChatgptActors::Actor.new(
  prompt: 'I want you to act as a virtual assistant. I will give you tasks and you will reply with the results of the tasks. I want you to only reply with the results of the tasks, and nothing else. Do not write explanations. My first task is ""I want you to write a short story about a cat"""'
)

# Initialize a random actor
actor = AwesomeChatgptActors::Actor.new(
  random: true
)

# Change the actor
actor.act_as(actor: 'Virtual Assistant', language: 'ru') # it will return the same actor with the new options, check the list in https://github.com/f/awesome-chatgpt-prompts/blob/main/prompts.csv

# Add a new actor to csv file
AwesomeChatgptActors::CastControl.add_actor(actor: 'Virtual Assistant', prompt: 'I want you to act as a virtual assistant. I will give you tasks and you will reply with the results of the tasks. I want you to only reply with the results of the tasks, and nothing else. Do not write explanations. My first task is ""I want you to write a short story about a cat"""')

# Remove an actor from csv file
AwesomeChatgptActors::CastControl.remove_actor(actor: 'Virtual Assistant')

# Get a list of all actors
AwesomeChatgptActors::CastoControl.actors

# Check if an actor exists
AwesomeChatgptActors::CastControl.actor_exists?(actor: 'Virtual Assistant')

# CSV file path
AwesomeChatgptActors::CastControl.csv_path # can be overriden by setting the environment variable CAST_CSV_PATH

# TEMP file path
AwesomeChatgptActors::CastControl.temp_path # can be overriden by setting the environment variable CAST_TEMP_PATH
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JesusGautamah/awesome-chatgpt-actors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/JesusGautamah/awesome-chatgpt-actors/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AwesomeChatgptActors project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/JesusGautamah/awesome-chatgpt-actors/blob/master/CODE_OF_CONDUCT.md).
