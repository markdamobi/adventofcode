require 'byebug'

require './opcode_13'

def run1(file: 'p13.txt')
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(1000, 0)

  arc = Arcade.new(list: list)
  arc.draw1
  arc.count_blocks
end

def run2(file: 'p13.txt', input: [])
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(1000, 0)
  arc = Arcade.new(list: list, input: input)
  arc.list[0] = 2
  ## note: this takes a few seconds. like 5 or so.
  arc.draw2
end

class Arcade
  def initialize(list:, size: 80, input: [])
    @list = list
    @grid = []
    size.times { grid << Array.new(size, ".") }
    @computer = Program.new(list: list, orig_input: input, arcade: self)
    @score = []
  end

  attr_reader :grid, :computer, :list, :score, :orig_jp

  def draw1
    while computer.last_code != 99
      ret = tick
      break unless ret
    end
  end

  def joystick_neutral?
    bp == jp
  end

  def joystick_left?
    bp < jp
  end

  def joystick_right?
    jp < bp
  end

  ## paddle position.
  def jp
    (0...grid.size).each do |i|
      x_offset = grid[i].index(3)
      if(x_offset != nil)
        return x_offset
      end
    end
  end

  # ball position.
  def bp
    (0...grid.size).each do |i|
      x_offset = grid[i].index(4)
      if(x_offset != nil)
        return x_offset
      end
    end
  end

  def draw2
    while computer.last_code != 99
      ret = tick2
      break unless ret
    end
    score[-1]
  end

  def count_blocks
    grid.flatten.count{ |x| x.to_i == 2 }
  end

  def tick
    x_off, y_off, tile = computer.compute, computer.compute, computer.compute
    return nil if [x_off, y_off, tile].any?(&:nil?)
    grid[y_off][x_off] = tile
    [x_off, y_off, tile]
  end

  def tick2
    x_off, y_off, tile = computer.compute, computer.compute, computer.compute
    return nil if [x_off, y_off, tile].any?(&:nil?)

    if(x_off == -1 && y_off == 0)
      @score << tile
      # puts tile
    else
      grid[y_off][x_off] = tile
    end
    [x_off, y_off, tile]
  end

  def display
    grid.each{ |row| puts row.join }
    nil
  end
end

