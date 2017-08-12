abstract class Command
  @signature          : String?
  @prefix             : String?
  @aliases            : Array(String)?
  @uses_global_prefix : Bool?
  @description        : String?

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
end
