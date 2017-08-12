require "./constants"

module Myhtml
  def self.tag_id_by_symbol(sym : Symbol)
    {% begin %}
    case sym
    {% for name in Lib::MyhtmlTags.constants %}
      when :{{ name.gsub(/MyHTML_TAG_/, "").downcase.id }}
        Lib::MyhtmlTags::{{ name.id }}
    {% end %}
    else
      raise Error.new("Unknown tag #{sym.inspect}")
    end
    {% end %}
  end

  def self.symbol_by_tag_id(tag_id : Lib::MyhtmlTags)
    {% begin %}
    case tag_id
    {% for name in Lib::MyhtmlTags.constants %}
      when Lib::MyhtmlTags::{{ name.id }}
        :{{ name.gsub(/MyHTML_TAG_/, "").downcase.id }}
    {% end %}
    else
      :unknown
    end
    {% end %}
  end

  @@tags_string_sym_map : Hash(String, Symbol)?

  def self.tags_string_sym_map
    @@tags_string_sym_map ||= begin
      h = Hash(String, Symbol).new
      {% for name in Lib::MyhtmlTags.constants.map(&.gsub(/MyHTML_TAG_/, "").downcase) %}
        h["{{ name.id }}"] = :{{ name.id }}
      {% end %}
      h
    end
  end

  def self.tag_symbol_by_string(str : String)
    tags_string_sym_map.fetch(str) { raise Error.new("Unknown tag #{str.inspect}") }
  end
end
