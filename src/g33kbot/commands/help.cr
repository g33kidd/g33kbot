class HelpCommand < Command
  global_prefix true
  signature "help"
  description "Lists commands"

  handle do |payload, client|
    fields = [] of Discord::EmbedField

    fields << Discord::EmbedField.new(
      name: "JavaScript Code Runner",
      value: "Run some javascript code with the JS Code Eval. \
      Try giving the bot some code to run by adding a JS Block as your only message. \
      If you don't know how to create **JS** code block, ask somebody in the server :smile:",
      inline: false
    )

    fields << Discord::EmbedField.new(
      name: "Chat Bot (powered by recast.ai)",
      value: "g33kbot will chat with you. Just send a message mentioning g33kbot and it will respond.\
      If that doesn't work, just send a DM mentioning g33kbot. You can stop the conversation at anytime by saying 'Stop'\
      in the chat room. **KEEP IN MIND** g33kbot try to understand and respond to every message you send in any channel \
      unless you stop the conversation.",
      inline: false
    )

    fields << Discord::EmbedField.new(
      name: "List of Commands",
      value: "Here's a list of all commands you can use, along with a short description of what they do.",
      inline: false
    )

    @bot.commands.each do |command|
      if !command.command_string.nil?
        fields.push Discord::EmbedField.new(
          name: command.command_string.not_nil!,
          value: command.description.not_nil!,
          inline: true
        )
      end
    end

    fields << Discord::EmbedField.new(
      name: "Need help?",
      value: "Message a moderator or g33k."
    )

    embed = Discord::Embed.new(
      title: "Commands and Features",
      description: "g33kbot has many commands and features you can use.\n",
      colour: 6348612_u32,
      timestamp: Time.now,
      footer: Discord::EmbedFooter.new(text: "glhf", icon_url: "https://cdn.discordapp.com/embed/avatars/0.png"),
      fields: fields
    )

    client.create_message payload.channel_id, "You asked for it. Here's some help.", embed
  end
end
