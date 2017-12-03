require "discordcr"
require "dotenv"
require "CrystalIrc"
require "./g33kbot/**"

# TODO: Support aliases.
#
# In order to do that we might need to reorganize how we handle messages, since
# recast maintains a conversation.
#
# If we're doing a conversation, other commands like contains might interfere.
# We don't want that.
#
# Maybe a priority for commands?
# ¯\_(ツ)_/¯

module G33kBot
  # Loads our .env file
  Dotenv.load

  unless ENV["TOKEN"]?
    puts "TOKEN not found in .env"
    exit 1
  end

  commands = [
    RecastController.new,
    PingCommand.new,
    TestCommand.new,
    CatsCommand.new,
    WowCommand.new,
    FlipCommand.new,
    PrefixCommand.new,
    HelpCommand.new,
    JavascriptEvalCommand.new,
  ]

  bot = Bot.new
  bot.add_commands(commands)
  bot.start
end
