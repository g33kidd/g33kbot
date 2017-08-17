class WowCommand < Command
  def run(runner, payload, client)
    client.create_message payload.channel_id, "Holy cow!"
  end

  def can_run?(payload, client) : Bool
    if payload.content.includes? "Wow!"
      true
    else
      false
    end
  end
end
