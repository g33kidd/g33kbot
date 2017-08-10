class CatsCommand < Command
  prefix "!"
  signature "cats"

  def run(payload, client)
    client.create_message payload.channel_id, "No cats here. Sorry! My fault."
  end
end
