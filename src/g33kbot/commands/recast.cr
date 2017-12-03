class RecastController < Command
  @conversations : Hash(UInt64, String)
  @recast_client : HTTP::Client
  @recast_header : HTTP::Headers

  description "Chat with bot."

  rules do |payload|
    mentions = payload.mentions.any? { |m| m.id == @bot.client.get_current_user.id ? true : false }
    has_conversation?(payload.author.id) || mentions ? true : false
  end

  def initialize
    @conversations = {} of UInt64 => String
    @recast_client = HTTP::Client.new "api.recast.ai", tls: true
    @recast_header = HTTP::Headers{
      "Authorization" => "Token #{ENV["RECAST"]}",
      "Content-Type"  => "application/json",
    }
  end

  handle do |payload, client|
    # TODO: Replace this with Regex to remove all mentions...
    # TODO: Maybe create a global message handler that handles all messages no matter
    # what. It's possible this message handler could be used to respond to the entire
    # server depending on what input it receives.
    # TODO: Periodically check if a user has been seeen and stop the conversation
    # if they haven't been seen in a while.
    content = payload.content.strip("<@#{client.get_current_user.id}>")

    if has_conversation?(payload.author.id)
      if !payload.content.starts_with? "Stop"
        conversation = @conversations[payload.author.id]
        results = converse(content, conversation)

        if !results.conversation_token.nil?
          update_conversation payload.author.id, results.conversation_token.not_nil!
        else
          end_conversation payload.author.id
        end

        handle_conversation(results, payload, client)
      else
        client.create_message payload.channel_id, "Okay, I'll stop chatting with you."
        end_conversation payload.author.id
      end
    else
      results = converse(content, nil)

      if !results.conversation_token.nil?
        update_conversation(payload.author.id, results.conversation_token.not_nil!)
      end

      handle_conversation(results, payload, client)
    end
  end

  def handle_conversation(results, payload, client)
    pp results

    if !results.action.nil? && !results.action.not_nil!.reply.nil?
      message = results.action.not_nil!.reply.to_s
      client.create_message payload.channel_id, emojify(message)
    else
      if !results.replies.nil?
        results.replies.not_nil!.each do |m|
          client.create_message payload.channel_id, emojify(m.to_s)
        end
      end
    end
  end

  def converse(text, token = nil)
    response = @recast_client.post(
      "/v2/converse",
      @recast_header,
      {"text": text, "conversation_token": token}.to_json
    )

    Response.from_json(response.body).results
  end

  def has_conversation?(user_id)
    @conversations.has_key?(user_id)
  end

  def update_conversation(user_id, conversation_token)
    @conversations[user_id] = conversation_token
  end

  def end_conversation(user_id)
    @conversations.delete user_id
  end

  def can_run?(payload, client)
  end
end
