class PingCommand < Command
  global_prefix true
  signature "ping"
  description "Ping? PONG!"

  handle do |payload, client|
    client.create_message payload.channel_id, "PONG!! Wow!"
  end
end
