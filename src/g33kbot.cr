require "discordcr"
require "dotenv"
require "./g33kbot/**"

# TODO: Support aliases in the command runner.
# TODO: Fix issues that didn't let us do runner.add_command()
# TODO: Fix issues regarding CommandRunner and Overloading...

# Loads our .env file.
hash = Dotenv.load

# Some variables
token = hash["TOKEN"]

# The Client
client = Discord::Client.new(token: "Bot #{token}", client_id: 345028468041580564_u64)

runner = CommandRunner.new [
  PingCommand.new,
  TestCommand.new,
  CatsCommand.new,
  WowCommand.new,
  FlipCommand.new
]

# Add all the commands!!!
# runner.add_command PingCommand.new
# runner.add_command TestCommand.new
# runner.add_command CatsCommand.new

# Client events
client.on_message_create do |payload|
  runner.run payload, client
end

# Start the bot
client.run
