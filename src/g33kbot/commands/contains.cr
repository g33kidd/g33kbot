class ContainsCommand < Command
  include Utils

  # NOTE: We could factor out the contains stuff from commands and just call them
  # "responses" which respond to the user based on their imput?
  # ¯\_(ツ)_/¯

  def run(runner, payload, client)
    client.create_message payload.channel_id, "Hello to you too!"
  end

  # Determines if this command can be run.
  def can_run?(content : String) : Bool
    if contains_any? content, ["hello", "Hello", "hElLo", "Hello!"]
      true
    else
      false
    end
  end
end
