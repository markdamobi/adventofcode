
require_relative './../p15'

describe "P15 part 1" do 
  it "passes test input" do 
    combat = Combat.new("../2018/p15_test2.txt")
    expect(combat.process).to eq 27730
  end
  it "passes test input" do 
    combat = Combat.new("../2018/p15_test3.txt")
    expect(combat.process).to eq 36334
  end
  it "passes test input" do 
    combat = Combat.new("../2018/p15_test4.txt")
    expect(combat.process).to eq 39514
  end
  it "passes test input" do 
    combat = Combat.new("../2018/p15_test5.txt")
    expect(combat.process).to eq 27755
  end
  it "passes test input" do 
    combat = Combat.new("../2018/p15_test6.txt")
    expect(combat.process).to eq 28944
  end
  it "passes test input" do 
    combat = Combat.new("../2018/p15_test7.txt")
    expect(combat.process).to eq 18740
  end

end