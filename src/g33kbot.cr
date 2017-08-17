require "discordcr"
require "dotenv"

require "./g33kbot/**"

struct Action
  JSON.mapping(
    slug: {type: String, nilable: true},
    done: {type: Bool, nilable: true},
    reply: {type: String, nilable: true}
  )
end
struct Results
  JSON.mapping(
    action: {type: Action, nilable: true},
    replies: {type: Array(String), nilable: true},
    conversation_token: {type: String, nilable: true}
  )
end
struct Response
  JSON.mapping(
    results: {type: Results, nilable: false}
  )
end

# TODO: Support aliases in the command runner.
# TODO: Merge code for Recast into the bot.
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
hash = Dotenv.load

# Some variables
token = hash["TOKEN"]

# The Client
client = Discord::Client.new(token: "Bot #{token}", client_id: 345028468041580564_u64)

# TODO: Make it easier to add commands, like preloading commands... ¯\_(ツ)_/¯
runner = CommandRunner.new [
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

# Client events
client.on_message_create do |payload|
  if payload.content.starts_with? "??"
    # client.create_message payload.channel_id, emojify(":)")
  else
    runner.run payload, client
  end
end

# Start the bot
client.run
