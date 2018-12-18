require_relative './../p18'

describe "P15 part 1" do 
  context "test 1" do 
    it "genereate lumbers and trees properly." do 
      lumber = Lumber.new("../2018/p18_test.txt")
      zero_min = 
      <<~HEREDOC
      .#.#...|#.
      .....#|##|
      .|..|...#.
      ..|#.....#
      #.#|||#|#|
      ...#.||...
      .|....|...
      ||...#|.#|
      |.||||..|.
      ...#.|..|.
      HEREDOC
      # byebug
      expect(lumber.state).to eq zero_min.strip

      one_min = <<~HEREDOC
      .......##.
      ......|###
      .|..|...#.
      ..|#||...#
      ..##||.|#|
      ...#||||..
      ||...|||..
      |||||.||.|
      ||||||||||
      ....||..|.
      HEREDOC
      lumber.tick
      expect(lumber.state).to eq one_min.strip

      two_min = <<~h
      .......#..
      ......|#..
      .|.|||....
      ..##|||..#
      ..###|||#|
      ...#|||||.
      |||||||||.
      ||||||||||
      ||||||||||
      .|||||||||
      h
      lumber.tick
      expect(lumber.state).to eq two_min.strip

      three_min = <<~h
      .......#..
      ....|||#..
      .|.||||...
      ..###|||.#
      ...##|||#|
      .||##|||||
      ||||||||||
      ||||||||||
      ||||||||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq three_min.strip

      four_min = <<~h
      .....|.#..
      ...||||#..
      .|.#||||..
      ..###||||#
      ...###||#|
      |||##|||||
      ||||||||||
      ||||||||||
      ||||||||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq four_min.strip

      five_min = <<~h
      ....|||#..
      ...||||#..
      .|.##||||.
      ..####|||#
      .|.###||#|
      |||###||||
      ||||||||||
      ||||||||||
      ||||||||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq five_min.strip

      six_min = <<~h
      ...||||#..
      ...||||#..
      .|.###|||.
      ..#.##|||#
      |||#.##|#|
      |||###||||
      ||||#|||||
      ||||||||||
      ||||||||||
      ||||||||||
      h
      lumber.tick 
      expect(lumber.state).to eq six_min.strip

      seven_min = <<~h
      ...||||#..
      ..||#|##..
      .|.####||.
      ||#..##||#
      ||##.##|#|
      |||####|||
      |||###||||
      ||||||||||
      ||||||||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq seven_min.strip 

      eight_min = <<~h
      ..||||##..
      ..|#####..
      |||#####|.
      ||#...##|#
      ||##..###|
      ||##.###||
      |||####|||
      ||||#|||||
      ||||||||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq eight_min.strip 

      nine_min = <<~h
      ..||###...
      .||#####..
      ||##...##.
      ||#....###
      |##....##|
      ||##..###|
      ||######||
      |||###||||
      ||||||||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq nine_min.strip 

      ten_min = <<~h
      .||##.....
      ||###.....
      ||##......
      |##.....##
      |##.....##
      |##....##|
      ||##.####|
      ||#####|||
      ||||#|||||
      ||||||||||
      h
      lumber.tick
      expect(lumber.state).to eq ten_min.strip 
    end
  end

end