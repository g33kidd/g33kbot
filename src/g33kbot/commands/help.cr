class HelpCommand < Command
  global_prefix true
  signature "help"
  description "Lists all of the commands that are available."

  def run(runner, payload, client)
    string = "Here's some help for yourself... \n\n"

    runner.commands.each do |c|
      prefix = nil
      prefix = runner.global_prefix if c.global_prefix?
      prefix = c.prefix if !c.prefix.nil?

      if !prefix.nil?
        if c.description.nil?
          string += "`#{prefix}#{c.signature}`\n\n"
        else
          string += "`#{prefix}#{c.signature}`\n#{c.description}\n\n"
        end
      end
    end

    client.create_message payload.channel_id, string
  end
end
