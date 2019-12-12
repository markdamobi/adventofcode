require 'byebug'
require './opcode'

def run1(file: 'p11.txt')
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(10000, 0)
  robot = Robot.new(instructions: list)
  robot.animate
  robot.panels.count{|k,v| v[:num_painted] > 0}
end

def run2(file: 'p11.txt')
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(10000, 0)
  robot = Robot.new(instructions: list, start: "#")
  robot.animate
  robot.display
end

class Robot
  def initialize(size: 100, instructions:, start: ".")
    @size = size
    @grid = []
    size.times{ @grid << Array.new(size, ".") }
    @x = size / 2 ## roughly center.
    @y = size / 2
    @grid[x][y] = start
    @direction = :up
    set_panels
    @computer = Program.new(list: instructions)
  end

  attr_reader :x, :y, :size, :grid, :direction, :computer, :panels

  def display
    (0...size).each do |i|
      (0...size).each do |j|
        if [x,y] == [i,j]
          print(direction_str)
        else
          print(grid[i][j])
        end
      end
      puts
    end
    nil
  end

  def direction_str
    case direction
    when :up
      "^"
    when :down
      "V"
    when :left
      "<"
    when :right
      ">"
    end
  end

  def tick
    output1 = computer.compute(input: [input])
    output2 = computer.compute(input: [])
    return computer.last_code if computer.last_code == 99
    paint(output1)
    turn(output2)
  end

  def animate
    while true
      val = tick
      break if val == 99
    end
  end

  def color
    return grid[x][y]
  end

  def input
    return 0 if color == "."
    return 1 if color == "#"
  end

  def set_panels
    @panels = {}
    (0...size).each do |i|
      (0...size).each do |j|
        @panels[[i, j]] = { num_painted: 0 }
      end
    end
  end

  def turn(num)
    turn_left if num == 0
    turn_right if num == 1
    move_forward
  end

  def turn_left
    case direction
    when :up
      @direction = :left
    when :left
      @direction = :down
    when :down
      @direction = :right
    when :right
      @direction = :up
    end
  end

  def turn_right
    case direction
    when :up
      @direction = :right
    when :right
      @direction = :down
    when :down
      @direction = :left
    when :left
      @direction = :up
    end
  end

  ## move 1 step in current direction
  def move_forward
    if direction == :up
      @x -= 1
    elsif direction == :right
      @y += 1
    elsif direction == :left
      @y -= 1
    elsif direction == :down
      @x += 1
    end
  end

  def paint(num)
    @grid[x][y] = "." if num == 0
    @grid[x][y] = "#" if num == 1
    @panels[[x,y]][:num_painted] = @panels[[x,y]][:num_painted] + 1
  end
end