class PingCommand < Command
  global_prefix true
  signature "ping"
  description "Pong? Ping? What?"

  def run(runner, payload, client)
    client.create_message payload.channel_id, "PONG!! Wow!"
  end
end
