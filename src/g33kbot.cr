require "discordcr"
require "dotenv"
require "CrystalIrc"

require "./g33kbot/**"

Dotenv.load

bot = Bot.new

# Setup the commands here..
bot.add_command PingCommand.new
bot.add_command TestCommand.new

bot.start

# TODO: Support aliases in the command runner.
# In order to do that we might need to reorganize how we handle messages, since
# recast maintains a conversation. We also don't want to have to mention the bot
# every time we want to chat with it.
#
# IF we're doing a conversation, other commands like contains might interfere.
# We don't want that.
#
# May a priority for commands?
# ¯\_(ツ)_/¯

# Loads our .env file.

# TODO: Make it easier to add commands, like preloading commands... ¯\_(ツ)_/¯
# runner = CommandRunner.new [
#   RecastController.new,
#   PingCommand.new,
#   TestCommand.new,
#   CatsCommand.new,
#   WowCommand.new,
#   FlipCommand.new,
#   PrefixCommand.new,
#   HelpCommand.new,
#   JavascriptEvalCommand.new,
# ]
#
# # Client events
# client.on_message_create do |payload|
#   runner.run payload, client
# end
#
# # Start the bot
# client.run
