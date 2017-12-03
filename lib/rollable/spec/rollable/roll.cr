describe Rollable::Roll do
  it "initialize" do
    r = Rollable::Roll.new [
      Rollable::Dice.new(1, 20),
      Rollable::FixedValue.new_dice(4),
    ]
    r.should be_a Rollable::Roll
    r.min.should eq 5
    r.max.should eq 24
    r.average.should eq 14.5
    10.times do
      (5..24).includes?(r.test).should eq true
    end
  end

  it "test (details)" do
    r = Rollable::Roll.new [Rollable::Dice.new(2, 6), Rollable::Dice.new(1, 4)]
    r.min_details.should eq([1, 1, 1])
    r.max_details.should eq([6, 6, 4])
    r.average_details.should eq([3.5, 3.5, 2.5])
    10.times do
      t = r.test_details
      (1..6).includes?(t[0]).should eq true
      (1..6).includes?(t[1]).should eq true
      (1..4).includes?(t[2]).should eq true
    end
  end

  it "parse (simple)" do
    (r1 = Rollable::Roll.parse("2d6+4")).should be_a(Rollable::Roll)
    r1.average.should eq 11
    (r2 = Rollable::Roll.parse("1")).should be_a(Rollable::Roll)
    r2.average.should eq 1
    (r3 = Rollable::Roll.parse("1d6")).should be_a(Rollable::Roll)
    r3.average.should eq 3.5
    (r4 = Rollable::Roll.parse("1d6+1")).should be_a(Rollable::Roll)
    r4.average.should eq 4.5
    (r5 = Rollable::Roll.parse("1d6-1")).should be_a(Rollable::Roll)
    r5.average.should eq 2.5
    r1.should be_a(Rollable::Roll)
    r1.min.should eq 6
    r1.max.should eq 16
    (Rollable::Roll.parse("!2d6+4").average > Rollable::Roll.parse("2d6+4").average).should be_true
  end

  it "parse (error)" do
    expect_raises { Rollable::Roll.parse("yolo") }
    Rollable::Roll.parse("yolo") { |_| true } rescue fail("must be catch in block")
  end

  it "parse (more)" do
    (r = Rollable::Roll.parse(" 1d6 - 1 + 2 - 1d6 ")).should be_a(Rollable::Roll)
    r.min.should eq -4
    r.max.should eq 6
    r.average.should eq 1
  end

  it "to_s" do
    Rollable::Roll.parse("1d6").to_s.should eq("1D6")
    Rollable::Roll.parse("-1d6").to_s.should eq("-1D6")
    Rollable::Roll.parse("4").to_s.should eq("4")
    Rollable::Roll.parse("-4").to_s.should eq("-4")
    Rollable::Roll.parse("-4 + 2D6").to_s.should eq("-4 + 2D6")
    Rollable::Roll.parse(" 1d6 - 1 + 2 - 1d6 ").to_s.should eq("1D6 - 1 + 2 - 1D6")
  end

  it "cmp" do
    r1 = Rollable::Roll.parse("2D6 + 1")
    r2 = Rollable::Roll.parse("2D6 + 2")
    r3 = Rollable::Roll.parse("2D8")
    # same tests than Dice and Die
    (r1 == r1).should eq true
    (r1 == r2).should eq false
    (r1 == r3).should eq false

    (r2 == r3).should eq false
    (r2 >= r3).should eq false
    (r2 <= r3).should eq true
    ((r2 <=> r3) < 0).should eq true
  end

  it "compact" do
    r = Rollable::Roll.parse("1D6 + 1D6")
    r.to_s.should eq("1D6 + 1D6")
    r.compact!
    r.to_s.should eq("2D6")
    Rollable::Roll.parse("1D6 + 1D6 + 1D4 + 2D6 + 1D4").compact!.to_s.should eq("4D6 + 2D4")
    Rollable::Roll.parse("1 + 1").compact!.to_s.should eq("2")
    Rollable::Roll.parse("1 + 1 + 2").compact!.to_s.should eq("4")
    Rollable::Roll.parse("1 + 1d6").compact!.to_s.should eq("1D6 + 1")
    Rollable::Roll.parse("1 + 2d6 + 3").compact!.to_s.should eq("2D6 + 4")
    Rollable::Roll.parse("2d8 + 1d6 + 1d20 + 5 + 2d8 + 1 + 2 + 1d6 + 1 + 1d6").compact!.to_s.should eq "4D8 + 3D6 + 1D20 + 9"
    Rollable::Roll.parse("2d8 + 1d6 + 1d20 + 5 + 2d8 + 1 + 2 - 1d6 - 1 + 1d6").compact!.to_s.should eq "4D8 + 1D6 + 1D20 + 7"
    Rollable::Roll.parse("1D6 + 1D6 - 2D6").compact!.size.should eq 0
  end

  it "order" do
    r = Rollable::Roll.parse("1D4 + 1D6")
    r.to_s.should eq("1D4 + 1D6")
    r.order.to_s.should eq("1D6 + 1D4")
    r.to_s.should eq("1D4 + 1D6")
    r.order!
    r.to_s.should eq("1D6 + 1D4")
  end
end
