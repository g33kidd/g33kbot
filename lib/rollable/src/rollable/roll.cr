require "./is_rollable"
require "./die"
require "./fixed_value"
require "./dice"

# `Roll` is a list of `Dice`.
#
# It is rollable, making the sum of each `Dice` values.
# It is also possible to get the details of a roll, using the methods
# `.min_details`, `.max_details`, `.average_details`, `.test_details`
#
# Example:
# ```
# r = Rollable.parse "1d6+2" # note: it also support "1d6 + 2"
# r.min                      # => 3
# r.max                      # => 9
# r.average                  # => 5.5
# r.test                     # => the sum of a random value in 1..6 and 2
# ```
class Rollable::Roll < Rollable::IsRollable
  @dice : Array(Dice)

  getter dice

  def initialize(@dice)
  end

  def clone
    Roll.new(@dice.clone)
  end

  delegate size, to: @dice

  # Reverse the values of the `Roll`.
  def reverse! : Roll
    @dice.each { |die| die.reverse! }
    self
  end

  # Return a reversed copy of the  `Roll`'s values.
  #
  # Example:
  # ```
  # Roll.parse("1d6").reverse # => -1d6
  # ```
  def reverse : Roll
    Roll.new @dice.map { |die| die.reverse }
  end

  {% for ft in ["min", "max", "test"] %}
  def {{ ft.id }} : Int32
    @dice.reduce(0) { |r, l| r + l.{{ ft.id }} }
  end

  def {{ (ft + "_details").id }} : Array(Int32)
    @dice.map {|dice| dice.{{ (ft + "_details").id }} }.flatten
  end
  {% end %}

  def average : Float64
    @dice.reduce(0.0) { |r, l| r + l.average }
  end

  def average_details : Array(Float64)
    @dice.map { |dice| dice.average_details }.flatten
  end

  def ==(right : Roll)
    @dice.size == right.dice.size && @dice.map_with_index { |e, i| right.dice[i] == e }.all? { |e| e == true }
  end

  {% for op in [">", "<", ">=", "<="] %}
  def {{ op.id }}(right : Roll)
    average != right.average ?
    average {{ op.id }} right.average :
    max != right.max ?
    max {{ op.id }} right.max :
    min {{ op.id }} right.min
  end
  {% end %}

  def <=>(right : Roll) : Int32
    average != right.average ? average - right.average <=> 0 : max != right.max ? max - right.max <=> 0 : min - right.min <=> 0
  end

  def order!
    @dice.sort! { |a, b| b <=> a }
    self
  end

  def order
    clone.order!
  end

  # let a [1d6, 1d4, 1d6, 2, 2d6]
  # first, we copy it
  # for 1d6 we check evey d6 in the copy, fetch and delete them
  def compact!
    i = 0
    until i >= @dice.size
      # fetch the current dice
      dice_current = @dice[i]
      dice_type = dice_current.die
      dice_count = dice_current.count
      # fetch all dice with the same type
      j = @dice.size
      until i >= j - 1
        j = j - 1
        if @dice[j].die == dice_type
          @dice[i].count += @dice[j].count
        elsif @dice[j].die == dice_type.reverse
          @dice[i].count -= @dice[j].count
        else
          next
        end
        @dice.delete_at j
      end
      i = i + 1
    end
    compact_fixed!
    compact_empty!
    self
  end

  private def compact_fixed!
    fixed = @dice.map_with_index { |d, idx| {d, idx} }
    fixed.select! { |t| t[0].die.fixed? }
    idx = 0
    fixed_dice = fixed.map do |t|
      @dice.delete_at(t[1] - idx)
      idx = idx + 1
      t[0].max
    end.sum
    @dice << FixedValue.new_dice(fixed_dice) if fixed_dice != 0
  end

  private def compact_empty!
    i = @dice.size - 1
    until i < 0
      @dice.delete_at(i) if @dice[i].count == 0
      i = i - 1
    end
  end

  def compact
    clone.compact!
  end
end

require "./roll/*"
