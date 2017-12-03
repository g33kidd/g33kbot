describe Rollable::FixedValue do
  it "new_die" do
    10.times do |i|
      n = i - 5
      f = Rollable::FixedValue.new_die n
      f.should be_a Rollable::Die
      f.min.should eq n
      f.max.should eq n
      f.average.should eq n
      f.test.should eq n
    end
  end

  it "new_dice" do
    a = Rollable::FixedValue.new_dice 5
    b = Rollable::Dice.new(1, Rollable::FixedValue.new_die(5))
    a.should eq b
    a = Rollable::FixedValue.new_dice -5
    b = Rollable::Dice.new(1, Rollable::FixedValue.new_die(-5))
    a.should eq b
  end
end
