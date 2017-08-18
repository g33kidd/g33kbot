abstract class Command
  @signature          : String?
  @prefix             : String?
  @aliases            : Array(String)?
  @uses_global_prefix : Bool?
  @description        : String?
  @bot                : Bot?

  @uses_global_prefix = false
  @description        = "Default description for a command until descriptions for all commands are set."

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
end

class Command
  def bind(bot : Bot)
    @bot = bot
  end

  def prefix
    @prefix
  end

  def description
    @description
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
end
