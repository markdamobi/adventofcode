
require_relative './../p15_2'

describe "P15 part 1" do 
  it "passes test input" do 
    combat = Combat2.new("../2018/p15_test2.txt")
    expect(combat.elves_win).to eq 4988
  end
  it "passes test input" do 
    combat = Combat2.new("../2018/p15_test4.txt")
    expect(combat.elves_win).to eq 31284
  end
  it "passes test input" do 
    combat = Combat2.new("../2018/p15_test5.txt")
    expect(combat.elves_win).to eq 3478
  end
  it "passes test input" do 
    combat = Combat2.new("../2018/p15_test6.txt")
    expect(combat.elves_win).to eq 6474
  end
  it "passes test input" do 
    combat = Combat2.new("../2018/p15_test7.txt")
    expect(combat.elves_win).to eq 1140
  end

end