class WowCommand < Command
  signature "Wow!"

  def run(payload, client)
    client.create_message payload.channel_id, "Holy cow!"
  end
end
