# Example: print all html tree

require "../src/myhtml"

def walk(node, level = 0)
  puts "#{" " * level}#{node.tag_name}#{node.attributes}(#{node.tag_text.strip})"
  node.children.each { |child| walk(child, level + 1) }
end

str = if filename = ARGV[0]?
        File.read(filename, "UTF-8", invalid: :skip)
      else
        "<html><Div><span class='test'>HTML</span></div></html>"
      end

parser = Myhtml::Parser.new(str)
walk(parser.root!)
