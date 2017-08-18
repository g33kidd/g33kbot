class Bot
  @client : Discord::Client
  @cache  : Discord::Cache
  @commands : Array(Command)
  @plugins  : Array(Plugin)

  def initialize
    @client = Discord::Client.new token: "Bot #{ENV["TOKEN"]}", client_id: 345028468041580564_u64
    @cache  = Discord::Cache.new @client

    @commands = [] of Command
    @plugins  = [] of Plugin

    @prefix = "??"
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

  def add_command(command : Command)
    command.bind self
    @commands << command
  end

  def add_plugin(plugin : Plugin)
    plugin.bind self
    @plugins << plugin
  end

  def reply(payload, message)
    @client.create_message payload.channel_id, message
  end

  def handle_ready(payload)
  end

  def handle_resume(payload)
  end

  def handle_message_create(payload)
    if @client.get_current_user.id != payload.author.id
      @plugins.each { |p| p.handle(payload) }
      @commands.each { |c| c.handle(payload) }
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
