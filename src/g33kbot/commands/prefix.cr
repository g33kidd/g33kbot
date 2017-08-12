class PrefixCommand < Command
  global_prefix true
  signature "prefix"
  description "Outputs a list of all command prefixes used."

  def run(runner, payload, client)
    prefix_list = runner.get_prefixes.uniq.join(", ")
    client.create_message(
      payload.channel_id,
      "The global prefix is #{runner.global_prefix}.\nOther prefixes include: #{prefix_list}"
    )
  end
end
