class Bot
  @client : Discord::Client
  @cache : Discord::Cache
  @commands : Array(Command)

  def initialize
    @client = Discord::Client.new token: "Bot #{ENV["TOKEN"]}", client_id: 345028468041580564_u64
    @cache = Discord::Cache.new @client

    @commands = [] of Command
    @signatures = [] of String

    @prefix = "$"
  end

  def start
    @client.on_ready { |r| handle_ready(r) }
    @client.on_resumed { |r| handle_resume(r) }
    @client.on_message_create { |m| handle_message_create(m) }
    @client.on_guild_create { |g| handle_guild_create(g) }
    @client.on_guild_member_add { |u| handle_guild_member_add(u) }
    @client.on_guild_member_remove { |u| handle_guild_member_remove(u) }
    @client.on_presence_update { |p| handle_presence_update(p) }
    @client.run
  end

  def client
    @client
  end

  def commands
    @commands
  end

  def cache
    @cache
  end

  def prefix
    @prefix
  end

  def add_command(command : Command)
    command.bind self
    @commands << command
  end

  def add_commands(commands : Array(Command))
    commands.each do |command|
      add_command(command)
    end
  end

  def reply(payload, message)
    @client.create_message payload.channel_id, message
  end

  def handle_ready(payload)
    puts "Client ready..."
  end

  def handle_resume(payload)
    puts "Client resume..."
  end

  def handle_message_create(payload)
    if !payload.author.bot
      @commands.each do |command|
        command.run(payload, @client)
      end
    end
  end

  def handle_guild_create(payload)
  end

  def handle_guild_member_add(payload)
  end

  def handle_guild_member_remove(payload)
  end

  def handle_presence_update(payload)
  end
end
