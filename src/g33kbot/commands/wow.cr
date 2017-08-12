class WowCommand < Command
  def run(runner, payload, client)
    client.create_message payload.channel_id, "Holy cow!"
  end

  def can_run?(content) : Bool
    if content.includes? "Wow!"
      true
    else
      false
    end
  end
end
