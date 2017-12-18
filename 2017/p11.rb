require 'active_support/all'
require 'byebug'
def read_file(file)
  File.read(file).strip.split(",")
end

class Hex
  attr_reader :directions, :origin, :x, :y, :dist

  def initialize(directions = [])
    @directions = directions
    @origin = [0,0]
    ### note: actual x coordinate needs to be multiplied by square root of 3.
    @x, @y = [0,0]
    @dist = 0
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

  def ne?
    x > 0 && y > 0
  end

  def se?
    x > 0 && y < 0
  end

  def nw?
    x < 0 && y > 0
  end

  def sw?
    x < 0 && y < 0
  end

  def n_or_s?
    x == 0 && y != 0
  end

  def e_or_w?
    x != 0 && y == 0
  end

  def origin?
    coord == origin
  end

  def d_from_origin
    if e_or_w?
      @dist = x.abs
    else
      @dist = (x.abs + y.abs)/2
    end
    dist
  end

  def coord
    [x,y]
  end

  def travel
    directions.each{|d| move(d.to_sym)}
  end
end


## this solution passess all the test cases.
## not sure why it doesn't work for the main input.
def run1
  # hex = Hex.new(read_file('2017/p11_test.txt'))
  hex = Hex.new(read_file('2017/p11_input.txt'))
  hex.travel
  hex.d_from_origin
end
