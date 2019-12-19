require_relative './opcode'

def run1(file: "p19.txt", size: 10)
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(10000, 0)
  beam = Beam.new(list: list, size: size)
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

  def count_affected
    grid.flatten.count{ |x| x == "#" }
  end

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

end