class CommandRunner
  @commands       : Array(Command)
  @global_prefix  : String

  @global_prefix  = "run! "

  # TODO: Rework how commands are handled.. in order to get Global Prefix working properly.

  def initialize(@commands : Array(Command))
  end

  def global_prefix
    @global_prefix
  end

  def commands
    @commands
  end

  # Runs the command runner, finding the command and running it etc..
  def run(payload, client)
    # ignore messages sent by this bot.
    if client.get_current_user.id != payload.author.id
      command = find_command(payload.content)
      if !command.nil?
        command.as(Command).run(self, payload, client)
      end
    end
  end

  # Gets all prefixes within all commands as an Array.
  def get_prefixes : Array(String)
    prefixes = [] of String
    @commands.each do |c|
      if !c.as(Command).prefix.nil?
        prefixes.push(c.as(Command).prefix.as(String))
      end
    end
    prefixes
  end

  # finds a command that is able to run given the content of the message.
  def find_command(content) : (Nil | Command)
    command = nil
    if !@commands.nil?
      @commands.not_nil!.each do |c|
        command = c if command_using_prefix?(c, content)
        command = c if command_using_global_prefix?(c, content)
        command = c if command_can_run?(c, content)
      end
    end
    command
  end

  # Checks if a command responds to a can_run? method and returns the command if so.
  def command_can_run?(command : Command, content) : Bool
    command.responds_to?(:can_run?) && command.can_run?(content)
  end

  # Checks if a command has prefix and signature set, if so, return the command.
  def command_using_prefix?(command : Command, content) : Bool
    if !command.prefix.nil?
      if content.not_nil!.starts_with? "#{command.prefix}"
        if content.not_nil!.strip("#{command.prefix}").starts_with? "#{command.signature}"
          true
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  # Does the command use a Global Prefix?
  def command_using_global_prefix?(command : Command, content) : Bool
    if command.global_prefix?
      if content.not_nil!.strip("#{@global_prefix}").starts_with? "#{command.signature}"
        true
      else
        false
      end
    else
      false
    end
  end
end
