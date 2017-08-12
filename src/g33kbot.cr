require "discordcr"
require "dotenv"
require "./g33kbot/**"

# TODO: Support aliases in the command runner.

# Loads our .env file.
hash = Dotenv.load

# Some variables
token = hash["TOKEN"]

# The Client
client = Discord::Client.new(token: "Bot #{token}", client_id: 345028468041580564_u64)

# TODO: Make it easier to add commands, like preloading commands... ¯\_(ツ)_/¯
runner = CommandRunner.new [
  PingCommand.new,
  TestCommand.new,
  CatsCommand.new,
  WowCommand.new,
  FlipCommand.new,
  ContainsCommand.new,
  PrefixCommand.new,
  HelpCommand.new,
  JavascriptEvalCommand.new
]

# Client events
client.on_message_create do |payload|
  runner.run payload, client
end

# Start the bot
client.run
