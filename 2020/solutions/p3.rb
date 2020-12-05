require_relative "../lib/base"

def part1(basename = 'p3_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
  Tree.new(input: input).tap(&:travel).tree_count
end

class Tree
  attr_reader :grid, :right, :down, :tree_count, :row, :col

  def initialize(input:, right: 3, down: 1)
    @grid = input
    @tree_count, @row, @col = 0, 0, 0
    @right, @down = right, down
  end

  def tick
    @tree_count += 1 if grid[row][col] == "#"

    @row += down
    @col = (col + right) % grid[0].size
  end

  def travel
    tick while @row < grid.size
  end
end

def part2(basename = 'p3_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
  slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]

  slopes.map do |right, down|
    Tree.new(input: input, right: right, down: down).tap(&:travel).tree_count
  end.reduce(:*)
end

### Helpers
def read_file(file)
  File.readlines(file).map { |line| parse(line) }
end

def parse(line)
  line = line.chomp.strip
end


# Running
# puts part1(file: 'p3.txt')
# puts part2(file: 'p3.txt')