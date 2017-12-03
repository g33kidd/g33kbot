describe Rollable::Die do
  it "initialize" do
    Rollable::Die.new(1..20).should be_a(Rollable::Die)
    Rollable::Die.new(10..20).should be_a(Rollable::Die)
    Rollable::Die.new(20).should be_a(Rollable::Die)
    Rollable::Die.new(20, true).should be_a(Rollable::Die)
    expect_raises { Rollable::Die.new(1001) }
  end

  it "min, max, average" do
    Rollable::Die.new(1..1).min.should eq 1
    Rollable::Die.new(1..1).max.should eq 1
    Rollable::Die.new(1..1).average.should eq 1
    Rollable::Die.new(1..20).min.should eq 1
    Rollable::Die.new(1..20).max.should eq 20
    Rollable::Die.new(1..20).average.should eq 10.5
    Rollable::Die.new(1..20, true).min.should eq 1
    Rollable::Die.new(1..20, true).max.should eq 80
    Rollable::Die.new(1..20, true).average.should eq (10.5*0.05**0 + 10.5*0.05**1 + 10.5*0.05**2 + 10.5*0.05**3).round(3)
  end

  it "test" do
    100.times do
      min = rand 1..10
      max = rand min..20
      ((min..max).includes? Rollable::Die.new(min..max).test).should eq(true)
    end
  end

  it "like?" do
    Rollable::Die.new(1..20).like?(Rollable::Die.new(1..20)).should eq true
    Rollable::Die.new(1..20).like?(Rollable::Die.new(-20..-1)).should eq true
    Rollable::Die.new(1..20).like?(Rollable::Die.new(1..10)).should eq false
    Rollable::Die.new(1..20, true).like?(Rollable::Die.new(1..20, false)).should eq true
  end

  it "negative?" do
    Rollable::Die.new(1..20).negative?.should eq false
    Rollable::Die.new(-1..20).negative?.should eq false
    Rollable::Die.new(1..-20).negative?.should eq false
    Rollable::Die.new(-1..-20).negative?.should eq true
    Rollable::Die.new(1..20, true).negative?.should eq false
    Rollable::Die.new(-1..-20, true).negative?.should eq true
  end

  it "fixed?" do
    Rollable::Die.new(1..20).fixed?.should eq false
    Rollable::Die.new(1..1).fixed?.should eq true
    Rollable::Die.new(20..20).fixed?.should eq true
    Rollable::Die.new(1).fixed?.should eq true
    Rollable::Die.new(1..20, true).fixed?.should eq false
    Rollable::Die.new(1, true).fixed?.should eq true
  end

  it "reverse" do
    Rollable::Die.new(1..20).reverse.min.should eq -20
    Rollable::Die.new(1..20).reverse.max.should eq -1
    Rollable::Die.new(1..1).reverse.min.should eq -1
    Rollable::Die.new(1..1).reverse.max.should eq -1
    Rollable::Die.new(1..20, true).reverse.min.should eq -20
    Rollable::Die.new(1..20, true).reverse.max.should eq -4
  end

  it "to_s" do
    Rollable::Die.new(1..20).to_s.should eq "D20"
    Rollable::Die.new(2..2).to_s.should eq "2"
    Rollable::Die.new(2..4).to_s.should eq "D(2,4)"
    Rollable::Die.new(1..20, true).to_s.should eq "!D20"
    Rollable::Die.new(2..4, true).to_s.should eq "!D(2,4)"
  end

  it "cmp" do
    (Rollable::Die.new(1..20) == Rollable::Die.new(1..20)).should eq true
    (Rollable::Die.new(1..20) == Rollable::Die.new(1..10)).should eq false
    (Rollable::Die.new(1..10) == Rollable::Die.new(1..20)).should eq false

    (Rollable::Die.new(1..20) != Rollable::Die.new(1..20)).should eq false
    (Rollable::Die.new(1..20) != Rollable::Die.new(1..10)).should eq true
    (Rollable::Die.new(1..10) != Rollable::Die.new(1..20)).should eq true

    (Rollable::Die.new(1..20) > Rollable::Die.new(1..20)).should eq false
    (Rollable::Die.new(1..20) > Rollable::Die.new(1..10)).should eq true
    (Rollable::Die.new(1..10) > Rollable::Die.new(1..20)).should eq false

    (Rollable::Die.new(1..20) >= Rollable::Die.new(1..20)).should eq true
    (Rollable::Die.new(1..20) >= Rollable::Die.new(1..10)).should eq true
    (Rollable::Die.new(1..10) >= Rollable::Die.new(1..20)).should eq false

    (Rollable::Die.new(1..20) < Rollable::Die.new(1..20)).should eq false
    (Rollable::Die.new(1..20) < Rollable::Die.new(1..10)).should eq false
    (Rollable::Die.new(1..10) < Rollable::Die.new(1..20)).should eq true

    (Rollable::Die.new(1..20) <= Rollable::Die.new(1..20)).should eq true
    (Rollable::Die.new(1..20) <= Rollable::Die.new(1..10)).should eq false
    (Rollable::Die.new(1..10) <= Rollable::Die.new(1..20)).should eq true

    # (Rollable::Die.new(2..6) <=> Rollable::Die.new(4..4) == 0).should eq true
    ((Rollable::Die.new(2..6) <=> Rollable::Die.new(4..4)) == 0).should eq false
    ((Rollable::Die.new(1..4) <=> Rollable::Die.new(1..4)) == 0).should eq true
    ((Rollable::Die.new(2..3) <=> Rollable::Die.new(1..4)) < 0).should eq true
    (Rollable::Die.new(2..6) == Rollable::Die.new(4..4)).should eq false

    # TODO: (Rollable::Die.new(1..20, true) == Rollable::Die.new(1..20, false)).should eq false
    # TODO: (Rollable::Die.new(1..20, true) > Rollable::Die.new(1..20, false)).should eq true
  end
end
