# coding: utf-8

class Rollable::Dice
  # Returns the `Dice` and the string parsed from `str`, in a `NamedTuple`
  # with "str" and "dice" keys.
  #
  # - If "strict" is true, then the string must end following the regex
  #   `\A(!)?\d+(d\d+)?\Z/i`
  #
  # - If "strict" is false, then the string doesn't have to finish following
  #   the regexp.
  private def self.parse_string(str : String, strict = true) : NamedTuple(str: String, dice: Dice)
    match = str.match(/\A(?<sign>-|\+)? *(?<exploding>!)?(?<count>\d+)(?:(?:d)(?<die>\d+))?#{strict ? "\\Z" : ""}/i)
    raise ParsingError.new("Parsing Error: dice, near to '#{str}'") if match.nil?
    sign = (match["sign"]? || "+") == "+" ? 1 : -1
    count = match["count"]
    die = match["die"]?
    exploding = match["exploding"]? ? true : false
    if die.nil?
      {str: match[0], dice: FixedValue.new_dice(sign * count.to_i)}
    else
      {str: match[0], dice: Dice.new(sign * count.to_i, die.to_i, exploding)}
    end
  end

  # Return a valid string parsed from `str`. (see `#parse_string`)
  #
  # Yields the `Dice` parsed from `str`.
  # Then, it returns the string read.
  # If strict is false, only the valid string is returned.
  # ```
  # Dice.parse("1d6") {|dice| dice.roll } => "1d6"
  # ```
  def self.parse(str : String, strict = true) : String
    data = parse_string(str, strict)
    yield data[:dice]
    return data[:str]
  end

  # Returns the `Dice` parsed. (see `#parse_string`)
  def self.parse(str : String, strict = true) : Dice
    data = parse_string(str, strict)
    return data[:dice]
  end

  # Returns the unconsumed string.
  #
  # Parse `str`, and yield a `Dice` parsed.
  # It does not requires to be a full valid string
  # (see #parse when strict is false).
  # ```
  # rest = Dice.consume("1d6+2") do |dice|
  #   # dice = Dice.new(1, Die.new(1..6))
  # end
  # # rest = "+2"
  # ```
  def self.consume(str : String) : String?
    str = str.strip
    consumed = parse(str, false) do |dice|
      yield dice
    end
    return consumed.size >= str.size ? nil : str[consumed.size..-1]
  end

  # Return a string which represents the `Dice`
  #
  # - If the value is fixed ```(n..n)```, then it return the @count * value
  # - Else, it just add the count before the `Dice` like "{count}{dice.to_s}"
  def to_s : String
    if fixed?
      (negative? ? "-" : "") + (@count * @die.min).abs.to_s
    else
      (negative? ? "-" : "") + "#{@count}" + (negative? ? @die.reverse : @die).to_s
    end
  end
end
