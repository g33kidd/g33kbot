require "./is_rollable"

# Not a front class. It is used to represent a type of dice with faces
#
# A `Die` is a range of Integer values.
# It is rollable.
#
# Example:
# ```
# d = Die.new(1..6)
# d.min     # => 1
# d.max     # => 6
# d.average # => 3.5
# d.test    # => a random value included in 1..6
# ```
# TODO: make it a Struct ?
class Rollable::Die < Rollable::IsRollable
  MAX = 1000
  EXPLODING_ITERATIONS = 4

  @faces : Range(Int32, Int32)
  getter exploding : Bool

  getter faces

  def initialize(@faces, @exploding = false)
    raise ParsingError.new "Cannot die with more than #{MAX} faces (#{@faces})" if @faces.size > MAX
    if @faces.end < @faces.begin
      @faces = @faces.end..@faces.begin
    end
  end

  def clone
    Die.new(@faces, @exploding)
  end

  def initialize(nb_faces : Int32, @exploding = false)
    raise ParsingError.new "Cannot die with more than #{MAX} faces (#{nb_faces})" if nb_faces > MAX
    @faces = 1..nb_faces
    if @faces.end < @faces.begin
      @faces = @faces.end..@faces.begin
    end
  end

  # Number of faces of the `Die`
  def size
    @faces.size
  end

  def fixed?
    size == 1
  end

  def negative?
    min < 0 && max < 0
  end

  def like?(other : Die)
    @faces == other.faces || @faces == other.reverse.faces
  end

  # Reverse the values
  #
  # Example:
  # ```
  # Die.new(1..6).reverse # => Die.new -6..-1
  # ```
  def reverse : Die
    Die.new -@faces.end..-@faces.begin, @exploding
  end

  def reverse!
    @faces = -@faces.end..-@faces.begin
    self
  end

  def max : Int32
    if @exploding
      @faces.end * EXPLODING_ITERATIONS
    else
      @faces.end
    end
  end

  def min : Int32
    @faces.begin
  end

  private def explode(&block)
    i = EXPLODING_ITERATIONS
    value = 0
    previous = [] of Int32
    while i > 0 && value != @faces.end
      value = @faces.to_a.sample
      previous << value
      i -= 1
      yield value, previous
    end
  end

  # Return a random value in the range of the dice
  def test : Int32
    if @exploding
      sum = 0
      explode { |value, _| sum += value }
      sum
    else
      @faces.to_a.sample
    end
  end

  # Mathematical expectation.
  #
  # A d6 will have a expected value of 3.5
  def average : Float64
    proba = @faces.size.to_f64
    non_exploding_average = @faces.reduce { |r, l| r + l }.to_f64 / proba
    if @exploding
      EXPLODING_ITERATIONS.times.reduce(0.0) {|base, i| base + non_exploding_average / proba ** i }.round(3)
    else
      non_exploding_average
    end
  end

  # Return a string.
  # - It may be a fixed value ```(n..n) => "#{n}"```
  # - It may be a dice ```(1..n) => "D#{n}"```
  # - Else, ```(a..b) => "D(#{a},#{b})"```
  def to_s : String
    string = if self.size == 1
               min.to_s
             elsif self.min == 1
               "D#{@faces.end}"
             else
               "D(#{@faces.begin},#{@faces.end})"
             end
    string = "!#{string}" if @exploding
    return string
  end

  def ==(right : Die)
    @faces == right.faces && @exploding == right.exploding
  end

  {% for op in [">", "<", ">=", "<="] %}
  def {{ op.id }}(right : Die)
    return false if @exploding != right.exploding
    average != right.average ?
    average {{ op.id }} right.average :
    max != right.max ?
    max {{ op.id }} right.max :
    min {{ op.id }} right.min
  end
  {% end %}

  def <=>(right : Die)
    average != right.average ? average - right.average <=> 0 : max != right.max ? max - right.max <=> 0 : min - right.min <=> 0
  end
end
#
