# MyHTML

[![Build Status](https://travis-ci.org/kostya/myhtml.svg?branch=master)](http://travis-ci.org/kostya/myhtml)

Crystal wrapper for HTML5 Parser https://github.com/lexborisov/myhtml

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  myhtml:
    github: kostya/myhtml
    branch: master
```

And run `crystal deps`

## Development Setup:

```shell
  git clone https://github.com/kostya/myhtml.git
  cd myhtml
  make

  crystal spec
```


## Usage

```crystal
# Example: print all html tree

require "myhtml"

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
```

Output:
```
html{}()
 head{}()
 body{}()
  div{}()
   span{"class" => "test"}()
    -text{}(HTML)
```


## More Examples

[examples](https://github.com/kostya/myhtml/tree/master/examples)

[specs](https://github.com/kostya/myhtml/tree/master/spec)

## CSS Selectors with shard modest

[modest](https://github.com/kostya/modest)

## Benchmark

Comparing with ruby-nokorigi(libxml), and crystal-crystagiri(libxml). Parse 1000 times google page, code: https://github.com/kostya/modest/tree/master/bench

```crystal
require "modest"
page = File.read("./google.html")
s = 0
links = [] of String
1000.times do
  myhtml = Myhtml::Parser.new(page)
  links = myhtml.css("div.g h3.r a").map(&.attribute_by("href")).to_a
  s += links.size
  myhtml.free
end
p links.last
p s
```


| Lang     |  Package           | Time, s | Memory, MiB |
| -------- | ------------------ | ------- | ----------- |
| Crystal  | modest(myhtml)     | 2.62    | 9.8         |
| Crystal  | Crystagiri(LibXML) | 19.89   | 11.5        |
| Ruby 2.2 | Nokogiri(LibXML)   | 45.82   | 136.2       |
