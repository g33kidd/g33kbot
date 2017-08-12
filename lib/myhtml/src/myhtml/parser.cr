module Myhtml
  struct Parser
    getter tree

    def initialize(tree_options : Lib::MyhtmlTreeParseFlags? = nil)
      options = Lib::MyhtmlOptions::MyHTML_OPTIONS_PARSE_MODE_SINGLE
      threads_count = 1
      queue_size = 0
      @tree = Tree.new(options, threads_count, queue_size, tree_options = nil)
    end

    def self.new(page : String, tree_options : Lib::MyhtmlTreeParseFlags? = nil)
      self.new(tree_options).parse(page)
    end

    def parse(string, encoding = Lib::MyhtmlEncodingList::MyHTML_ENCODING_UTF_8)
      pointer = string.to_unsafe
      bytesize = string.bytesize

      if Lib.encoding_detect_and_cut_bom(pointer, bytesize, out encoding2, out pointer2, out bytesize2)
        pointer = pointer2
        bytesize = bytesize2
        encoding = encoding2
      end

      res = Lib.parse(@tree.raw_tree, encoding, pointer, bytesize)
      raise Error.new("parse error #{res}") if res != Lib::MyhtmlStatus::MyHTML_STATUS_OK
      self
    end

    # Dangerous, free object
    def free
      @tree.free
    end

    {% for name in %w(root html head body) %}
      delegate {{ name.id }}, to: @tree
      delegate {{ name.id }}!, to: @tree
    {% end %}

    def nodes(tag_id : Myhtml::Lib::MyhtmlTags)
      EachTagIterator.new(@tree, tag_id)
    end

    def nodes(tag_sym : Symbol)
      nodes(Myhtml.tag_id_by_symbol(tag_sym))
    end

    def nodes(tag_str : String)
      nodes(Myhtml.tag_symbol_by_string(tag_str))
    end
  end
end
