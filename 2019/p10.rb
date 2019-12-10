require 'byebug'

def run1(file: 'p10.txt')
  list = File.readlines(file).map{ |l| l.chomp.strip.split("") }
  monitor = Monitor.new(grid: list)
end

class Monitor
  def initialize(grid:)
    @grid = grid
    @rows = grid.size
    @cols = grid[0].size
    set_asteroids
  end

  attr_reader :grid, :rows, :cols, :asteroids

  def count_asteriods

  end

  def get_max_views
    max_slopes = 0
    max_coord = nil

    (0...rows).each do |i|
      (0...cols).each do |j|
        next unless grid[i][j] == "#"
        num_of_slopes = num_slopes(i, j)
        if(num_of_slopes > max_slopes)
          max_slopes = num_of_slopes
          max_coord = [i, j]
        end
      end
    end
    p max_coord.reverse
    max_slopes
  end

  def num_slopes(x,y)
    slopes = []
    (asteroids - [[x,y]]).each do |x2, y2|
      p1 = Point.new(x:x, y:y)
      p2 = Point.new(x:x2, y:y2)
      slope = p1.slope(p2)
      slopes << slope
    end

    slopes.uniq.size
  end

  def set_asteroids
    @asteroids = []
    (0...rows).each do |i|
      (0...cols).each do |j|
        @asteroids << [i, j] if grid[i][j] == "#"
      end
    end
  end


end

class Point
  def initialize(x:, y:)
    @x = x
    @y = y
  end

  attr_reader :x, :y

  def slope(p2)
    if x == p2.x
      return 10000 if(p2.y > y)
      return -10000 if(p2.y < y)
    end

    if y == p2.y
      return 50000 if(p2.x > x)
      return -50000 if(p2.x < x)
    end

    sign = "#{s(x, p2.x)}, #{s(y, p2.y)}"
    [Rational(p2.y - y, p2.x - x), sign]
  end

  def s(a,b)
    "++-"[a <=> b]
  end
end