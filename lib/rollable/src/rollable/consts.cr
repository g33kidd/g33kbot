require "./roll"

module Rollable
  D100 = Roll.parse "1d100"
  D20  = Roll.parse "1d20"
  D12  = Roll.parse "1d12"
  D10  = Roll.parse "1d10"
  D8   = Roll.parse "1d8"
  D6   = Roll.parse "1d6"
  D4   = Roll.parse "1d4"
  D3   = Roll.parse "1d3"
end
