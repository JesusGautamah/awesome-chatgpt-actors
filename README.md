# Awesome ChatGPT Actors

This gem is a collection of actors made with [Awesome Chatgpt Prompts](https://github.com/f/awesome-chatgpt-prompts) in ruby.
So for prompts information, please refer to that repository.
The prompts was edited and translated to brazillian portuguese, so it can be used in english and portuguese.
The actors is currently been tested, and it's default values will be changed in the future.

## Requirements
- Ruby 2.6 or higher

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add awesome_chatgpt_actors

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install awesome_chatgpt_actors

Add to your rakefile:

    require 'awesome_chatgpt_actors'

    AwesomeChatgptActors.load_tasks

Run in the command line:

    $ rake chatgpt_actors:install
## Usage

```ruby
require 'awesome_chatgpt_actors'

# Initialize a new actor with default options
actor = AwesomeChatgptActors::Actor.new

# it will return an actor with the following options
# {
#   role: 'Virtual Assistant',
#   prompt: 'I want you to act as a virtual assistant. I will give you tasks and you will reply with the results of the tasks. I want you to only reply with the results of the tasks, and nothing else. Do not write explanations. My first task is ""I want you to write a short story about a cat""",
#   actors_csv: csv_path_of_current_actor,
#   accertivity: 1, # 1 is the most accertive, 2 is the least accertiv, this is called as temperature in openai
#   default_frequency: 0, # can be changed if you define a default prompt to when instance is initialized
#   default_presence: 0, # can be changed if you define a default prompt to when instance is initialized
#   has_placeholder: false, # has a placeholder in the prompt or role to be replaced by the user input
#   language: 'en', # pt for portuguese, en for english, it can be changed even if you don't provide an default prompt
# }

# Initialize a new actor with options
actor = AwesomeChatgptActors::Actor.new(
  role: 'Virtual Assistant', # DEFAULT. Not required. The type of actor to use, check the list in https://github.com/f/awesome-chatgpt-prompts/blob/main/prompts.csv
  language: 'en', # DEFAULT. Not required. The language of the prompt, if other language is specified, it will requirean openai api key to perform the translation
)

# Initialize a new actor with othe acceptable language
actor = AwesomeChatgptActors::Actor.new(
  language: 'pt',
)

# Initialize a new actor with a different role and language
actor = AwesomeChatgptActors::Actor.new(
  role: 'Virtual Assistant',
  language: 'pt',
)

# Initialize a new actor with a different attributes
## To change the attributes, you need to initialize the actor with a different prompt or it will use the default prompt of the role
actor = AwesomeChatgptActors::Actor.new(
  role: 'Virtual Assistant',
  language: 'en',
  prompt: 'I want you to act as a virtual assistant. I will give you tasks and you will reply with the results of the tasks. I want you to only reply with the results of the tasks, and nothing else. Do not write explanations. My first task is ""I want you to write a short story about a cat"""',
  accertivity: 1, # 1 is the most accertive, 2 is the least accertiv, this is called as temperature in openai
  default_frequency: 0, # can be changed if you define a default prompt to when instance is initialized
  default_presence: 0, # can be changed if you define a default prompt to when instance is initialized
  has_placeholder: false, # has a placeholder in the prompt or role to be replaced by the user input
)

# Initialize a random actor
actor = AwesomeChatgptActors::Actor.new(
  random: true,
)


# Initialize a random actor with a different language
actor = AwesomeChatgptActors::Actor.new(
  random: true,
  language: 'pt',
)


# Change the actor
actor.act_as('Virtual Assistant') # it will return the same actor with the new options, check the list in https://github.com/f/awesome-chatgpt-prompts/blob/main/prompts.csv

# Add a new actor to csv file
## The actor will be added to the csv file with the default options, the only required option is the actor role and prompt, if a different language is specified, it will add the prompt in the language specified csv file
AwesomeChatgptActors::CastControl.add_actor(actor: 'Virtual Assistant', prompt: 'I want you to act as a virtual assistant. I will give you tasks and you will reply with the results of the tasks. I want you to only reply with the results of the tasks, and nothing else. Do not write explanations. My first task is ""I want you to write a short story about a cat"""', has_placeholder: false, accertivity: 1, default_frequency: 0, default_presence: 0, language: 'en')

# Remove an actor from csv file
## The actor will be removed from the csv file, if a different language is specified, it will remove the actor from the language specified csv file
AwesomeChatgptActors::CastControl.remove_actor(actor: 'Virtual Assistant', language: 'en')

# Get a list of all actors
AwesomeChatgptActors::CastControl.actors

# Get a list of all actors in a different language
AwesomeChatgptActors::CastControl.actors_pt

# Check if an actor exists
AwesomeChatgptActors::CastControl.actor_exists?(actor: 'Virtual Assistant')

# Check if an actor exists in a different language
AwesomeChatgptActors::CastControl.actor_exists_in_pt?(actor: 'Virtual Assistant')

# CSV file path
AwesomeChatgptActors::CastControl.csv_path # can be overriden by setting the environment variable CAST_CSV_PATH

# CSV file path in a different language
AwesomeChatgptActors::CastControl.pt_csv_path # can be overriden by setting the environment variable CAST_CSV_PATH_PT

# TEMP file path
AwesomeChatgptActors::CastControl.temp_path # can be overriden by setting the environment variable CAST_TEMP_PATH
```

## Testing
Create a .env_test file with the same variables as the .env file, but with the test values.
This gem was tested with Rspec. To run the tests, execute:

    $ bundle exec rspec

<!-- Coverage: -->
<!-- local image path: coverage-image/simplecov-actors.png -->
[![Coverage Status](https://raw.githubusercontent.com/JesusGautamah/awesome-chatgpt-actors/master/coverage-image/simplecov-actors.png)](  https://raw.githubusercontent.com/JesusGautamah/awesome-chatgpt-actors/master/coverage-image/simplecov-actors.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JesusGautamah/awesome-chatgpt-actors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/JesusGautamah/awesome-chatgpt-actors/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AwesomeChatgptActors project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/JesusGautamah/awesome-chatgpt-actors/blob/master/CODE_OF_CONDUCT.md).
