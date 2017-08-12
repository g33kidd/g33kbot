class CatsCommand < Command
  global_prefix true
  signature "cat"
  description "Supposed to get a random image of a cat."

  def run(runner, payload, client)
    client.create_message payload.channel_id, "No cats here. Sorry! My fault."
  end
end
