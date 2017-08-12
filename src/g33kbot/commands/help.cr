class HelpCommand < Command
  global_prefix true
  signature     "help"
  description   "Lists all of the commands that are available."

  def run(runner, payload, client)
    fields = [] of Discord::EmbedField
    runner.commands.each do |c|
      prefix = nil
      prefix = runner.global_prefix if c.global_prefix?
      prefix = c.prefix if !c.prefix.nil?

      if !prefix.nil?
        if c.description.nil?
          fields.push Discord::EmbedField.new(name: "#{prefix}#{c.signature}", value: "No description set.")
          # string += "`#{prefix}#{c.signature}`\n\n"
        else
          fields.push Discord::EmbedField.new(
            name: "#{prefix}#{c.signature}",
            value: "#{c.description}"
          )
          # string += "`#{prefix}#{c.signature}`\n#{c.description}\n\n"
        end
      end
    end

    embed = Discord::Embed.new(
      title: "List of Commands",
      timestamp: Time.now,
      fields: fields
    )

    client.create_message payload.channel_id, "", embed
  end
end
