abstract class Command
  @signature  : String?
  @prefix     : String?
  @aliases    : Array(String)?

  macro prefix(string)
    @prefix = {{string}}
  end
  macro signature(string)
    @signature = {{string}}
  end
  macro aliases(array)
    @aliases = {{array}}
  end
end

class Command
  def prefix
    @prefix
  end

  def signature
    @signature
  end

  def aliases
    @aliases
  end
end
