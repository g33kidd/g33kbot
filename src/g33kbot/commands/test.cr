class TestCommand < Command
  # prefix "!"
  global_prefix true
  signature "test"
  description "This is test? Hello?"

  def run(runner, payload, client)
    client.create_message payload.channel_id, "Yes, this is test, hello."
  end
end
