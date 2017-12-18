require 'active_support/all'
require 'byebug'
def read_file(file)
  File.read.strip.split(",")
end

class Hex
  attr_reader :directions, :origin, :x, :y

  def initialize(directions)
    @directions = directions
    @origin = [0,0]
    @pointer = [0,0]

  end

  def move(dir)
    case dir

    when :n
      @y += 1
    when :s
      @y -= 1
    when :ne
      @x += 0.75
      @y += 0.5
    when :se
      @x += 0.75
      @y -= 0.5
    when :nw
      @x -= 0.75
      @y += 0.5
    when :sw
      @x -= 0.75
      @y -= 0.5
    end
  end

  def distance(a, b)

  end

  def coord
    [x,y]
  end
end


def run1
  # h = Hex.new(read_file('2017/p11_test.txt'))
  h = Hex.new(read_file('2017/p11_input.txt'))
  s.some_method
end
