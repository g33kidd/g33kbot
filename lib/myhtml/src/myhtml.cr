module Myhtml
  VERSION = "0.12"

  class Error < Exception
  end

  def self.lib_version
    v = Lib.version
    {v.major, v.minor, v.patch}
  end

  def self.version_string
    "#{VERSION} (libmyhtml #{lib_version.join('.')})"
  end

  # TODO: rewrite to optimal, this is slow
  def self.decode_html_entities(str : String)
    return str if str.empty?
    parser = Myhtml::Parser.new(str, tree_options: Myhtml::Lib::MyhtmlTreeParseFlags::MyHTML_TREE_PARSE_FLAGS_WITHOUT_DOCTYPE_IN_TREE)
    if child = parser.body!.child
      child.tag_text
    else
      str
    end
  ensure
    parser.try &.free
  end
end

require "./myhtml/*"
