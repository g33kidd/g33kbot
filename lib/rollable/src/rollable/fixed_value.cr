require "./die"

# Allows to create a die with a fixed value.
# The die will only gives this value everytime.
# (`.min`, `.max`, `.test`, `.average`)
#
# This is equivalent to
# ```
# Die.new(n..n)              # => FixedValue.new_die n
# Dice.new(1, Die.new(n..n)) # => FixedValue.new_dice n
# ```
module Rollable::FixedValue
  # Return a `Die` with only one face.
  def self.new_die(value : Int32)
    Die.new value..value
  end

  # Return a `Dice` with only one face.
  def self.new_dice(fixed : Int32)
    Dice.new 1, FixedValue.new_die(fixed)
  end
end
