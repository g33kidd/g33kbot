class TestCommand < Command
  prefix "!"
  signature "test"

  def run(payload, client)
    client.create_message payload.channel_id, "Yes, this is test, hello."
  end
end
