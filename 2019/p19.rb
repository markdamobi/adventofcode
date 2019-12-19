require_relative './opcode'

def run1(file: "p19.txt", size: 50)
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(10000, 0)
  beam = Beam.new(list: list, size: size)
  beam.populate
  beam.count_affected
end


## running with size of 2000 works fine. takes some time(maybe 15 mins) but it eventually gets answer.
def run2(file: "p19.txt", size: 2000)
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(10000, 0)
  beam = Beam.new(list: list, size: size)
  beam.populate2
  x, y = beam.get_coords(n: 100)
  x * 10000 + y
end



class Beam
  def initialize(list:, size: 10)
    @list = list
    @size = size
    @grid = []
    size.times{ @grid << Array.new(size, ".") }
  end

  attr_reader :grid, :list, :size

  def populate
    (0...size).each do |i|
      (0...size).each do |j|
        val = get_v(x: j, y: i)
        if val == 1
          @grid[i][j] = "#"
        elsif val == 0
          @grid[i][j] = "."
        end
      end
    end
  end

  def populate2
    prev_j = 0
    (0...size).each do |i|
      found = 0
      (prev_j...size).each do |j|
        val = get_v(x: j, y: i)
        if val == 1
          @grid[i][j] = "#"
          found += 1
          prev_j = j if found == 1 ## slight optimization to skip filling in unnecessary blanks at beginning of line.
        elsif val == 0
          @grid[i][j] = "."
          break if found > 0 ## slight optimization to stop filling in unnecessary blanks at end of line.
        end
      end
    end
  end

  def count_affected
    grid.flatten.count{ |x| x == "#" }
  end

  ## this just gets the value to be put in a particular coordinate.
  def get_v(x:, y:)
    computer = Program.new(list: list.dup, orig_input: [x,y])
    computer.compute
  end

  def display
    (0...size).each do |i|
      (0...size).each do |j|
        print(grid[i][j])
      end
      puts
    end
    nil
  end

  def get_coords(n:)
    (0...grid.size).each do |i|
      j = grid[i].index("#")
      next if j == nil
      while(grid[i][j] == "#")
        break if (i+n-1) >= grid.size
        if(grid[i][j+n-1] == "#" && grid[i+n-1][j] == "#")
          return [j, i]
        end
        j += 1
      end
    end
    nil
  end

end