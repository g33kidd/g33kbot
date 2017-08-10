class PingCommand < Command
  prefix "!"
  signature "ping"

  def run(payload, client)
    client.create_message payload.channel_id, "PONG!! Wow!"
  end
end
