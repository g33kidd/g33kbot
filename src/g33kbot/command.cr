abstract class Command
  @signature : String?
  @prefix : String?
  @aliases : Array(String)?
  @uses_global_prefix : Bool?
  @description : String?
  @bot : Bot

  @uses_global_prefix = false
  @description = "Default description for a command until descriptions for all commands are set."
  @bot = Bot.new

  @prefix = nil

  macro prefix(string)
    @prefix = {{string}}
  end

  macro signature(string)
    @signature = {{string}}
  end

  macro aliases(array)
    @aliases = {{array}}
  end

  macro global_prefix(bool)
    @uses_global_prefix = {{bool}}
  end

  macro description(text)
    @description = {{text}}
  end

  macro rules(&block)
    def rules(payload)
      {{block.body}}
    end
  end

  macro handle(&block)
    def handle(payload, client)
      {{block.body}}
    end
  end
end

class Command
  def bind(bot : Bot)
    @bot = bot
  end

  def prefix
    if !@prefix.nil?
      @prefix
    else
      if @uses_global_prefix
        @bot.prefix
      end
    end
  end

  def description
    if !@description.nil?
      @description
    else
      "No description."
    end
  end

  def signature
    @signature
  end

  def aliases
    @aliases
  end

  def global_prefix?
    @uses_global_prefix
  end

  def emojify(content)
    content.gsub ":D", ":smile:"
    content.gsub ":)", ":smiley:"
    content.gsub "<3", ":heart:"
    content.gsub ":(", ":frowning:"
  end

  def command_string
    if !prefix.nil? && !signature.nil?
      "#{prefix}#{signature}"
    else
      nil
    end
  end

  def is_command?(payload)
    return !command_string.nil? && payload.content.starts_with?(command_string.not_nil!)
  end

  def run(payload, client)
    runnable = false

    if self.responds_to?(:rules)
      if !is_command?(payload)
        runnable = self.rules(payload)
      end
    else
      if is_command?(payload)
        runnable = true
      end
    end

    if runnable
      self.handle(payload, client)
    else
      # Nothing
    end
  end
end
