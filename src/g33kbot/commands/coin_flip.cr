class FlipCommand < Command
  # Usage: !flip
  #
  # This command just randomizes between 1 and 0 and sends a message saying which
  # face the coin landed on.

  prefix "!"
  signature "flip"


  def run(payload, client)
    Random.new_seed
    coin = Random.rand(2)
    coin_str = ""

    coin_str = "Tails" if coin == 0
    coin_str = "Heads" if coin == 1

    client.create_message(payload.channel_id, "**You** flipped a coin. It landed on: **#{coin_str}** whew.")
  end
end
