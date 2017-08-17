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
      command = find_command(payload, client)
      if !command.nil?
        client.trigger_typing_indicator payload.channel_id
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
  def find_command(payload, client) : (Nil | Command)
    command = nil
    if !@commands.nil?
      @commands.not_nil!.each do |c|
        command = c if command_using_prefix?(c, payload.content)
        command = c if command_using_global_prefix?(c, payload.content)
        command = c if command_can_run?(c, payload, client)
      end
    end
    command
  end

  def get_command_string(command)
    prefix = nil
    prefix = global_prefix if command.global_prefix?
    prefix = command.prefix if !command.prefix.nil?

    if !prefix.nil?
      "#{prefix}#{command.signature}"
    end
  end

  # Checks if a command responds to a can_run? method and returns the command if so.
  def command_can_run?(command : Command, payload, client) : Bool
    command.responds_to?(:can_run?) && command.can_run?(payload, client) ? true : false
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
