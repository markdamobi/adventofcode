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
    ### note: actual x coordinate needs to be multiplied by square root of 3.
    @x, @y = [0,0]
    # @pointer = [0,0]

  end

  def move(dir)
    case dir

    when :n
      @y += 2
    when :s
      @y -= 2
    when :ne
      @x += 1
      @y += 1
    when :se
      @x += 1
      @y -= 1
    when :nw
      @x -= 1
      @y += 1
    when :sw
      @x -= 1
      @y -= 1
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
