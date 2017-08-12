module Myhtml
  class Tree
    getter raw_myhtml, raw_tree

    def initialize(options = Lib::MyhtmlOptions::MyHTML_OPTIONS_PARSE_MODE_SINGLE, threads_count = 1, queue_size = 0, tree_options : Lib::MyhtmlTreeParseFlags? = nil)
      @raw_myhtml = Lib.create
      res = Lib.init(@raw_myhtml, options, threads_count, queue_size)
      if res != Lib::MyhtmlStatus::MyHTML_STATUS_OK
        raise Error.new("init error #{res}")
      end

      @raw_tree = Lib.tree_create
      res = Lib.tree_init(@raw_tree, @raw_myhtml)

      Lib.tree_parse_flags_set(@raw_tree, tree_options) if tree_options

      if res != Lib::MyhtmlStatus::MyHTML_STATUS_OK
        Lib.destroy(@raw_myhtml)
        raise Error.new("tree_init error #{res}")
      end
      @finalized = false
    end

    def free
      unless @finalized
        @finalized = true
        Lib.tree_destroy(@raw_tree)
        Lib.destroy(@raw_myhtml)
      end
    end

    def finalize
      free
    end

    {% for name in %w(head body html root) %}
      def {{ name.id }}
        Node.from_raw(self, Lib.tree_get_node_{{(name == "root" ? "html" : name).id}}(@raw_tree))
      end

      def {{ name.id }}!
        if val = {{ name.id }}
          val
        else
          raise Error.new("Empty node, expected `{{name.id}}` to present on tree")
        end
      end
    {% end %}
  end
end
