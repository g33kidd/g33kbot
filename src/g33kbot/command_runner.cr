class CommandRunner
  @commands : Array(Command)

  def initialize(@commands : Array(Command))
  end

  # Runs the command runner, finding the command and running it etc..
  def run(payload, client)
    # ignore messages sent by this bot.
    if client.get_current_user.id != payload.author.id
      command = find_command(payload.content)
      command.run(payload, client)
    end
  end

  # TODO: Figure out how we can do this without having to return an EmptyCommand
  # for a command not found? Or maybe it's fine ¯\_(ツ)_/¯
  def find_command(content : String) : Command
    command = EmptyCommand.new

    if !@commands.nil?
      @commands.not_nil!.each do |c|

        if !c.prefix.nil?
          if content.not_nil!.starts_with? "#{c.prefix}"
            if content.not_nil!.strip("#{c.prefix}").starts_with? "#{c.signature}"
              command = c
            end
          end
        else
          if content.not_nil!.starts_with? "#{c.signature}"
            command = c
          end
        end

      end
    end

    command
  end
end
