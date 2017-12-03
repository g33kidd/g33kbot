describe Rollable do
  it "consts" do
    Rollable::D100.max.should eq 100
    Rollable::D20.max.should eq 20
    Rollable::D12.max.should eq 12
    Rollable::D10.max.should eq 10
    Rollable::D8.max.should eq 8
    Rollable::D6.max.should eq 6
    Rollable::D4.max.should eq 4
    Rollable::D3.max.should eq 3
  end
end
