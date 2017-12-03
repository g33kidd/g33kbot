class PrefixCommand < Command
  global_prefix true
  signature "prefix"
  description "Lists prefixes."

  handle do |payload, client|
    client.create_message payload.channel_id, "this doesn't work right now."
  end
end
