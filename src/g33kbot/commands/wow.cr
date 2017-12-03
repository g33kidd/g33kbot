class WowCommand < Command
  global_prefix true
  signature "wow"
  description "Wow!"

  handle do |payload, client|
    client.create_message payload.channel_id, "Holy cow!"
  end
end
