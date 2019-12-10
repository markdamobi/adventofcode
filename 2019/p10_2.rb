require 'byebug'

def run1(file: 'p10.txt', death_time: 200, x:26, y:29)
  list = File.readlines(file).map{ |l| l.chomp.strip.split("") }
  vaporizer = Vaporizer.new(grid: list, x: x, y: y)
  # vaporizer.vaporize
  # ast = vaporizer.asteroids.select{ |k,v| v.time_of_death == death_time }.values.first
  # p ast
  # ast.x * 100 + ast.y
end

class Vaporizer
  def initialize(grid:, x:, y:)
    @x = x
    @y = y
    @p1 = Point.new(x: x, y: y)
    @grid = grid
    @rows = grid.size
    @cols = grid[0].size
    @vaporized = []
    @los = 0 #line of sight
    set_asteroids
    set_angles
    set_angles_group
    @death_number = 0
  end

  attr_reader :x, :y, :p1, :grid, :death_number, :group_by_angle, :los, :rows, :cols, :asteroids, :vaporized

  def set_angles
    @asteroids.each do |k, as|
      # p2 = Point.new(x: k[0], y: k[1])
      @asteroids[k].set_angle(p1)
    end
  end

  def kill_next
    as = nil
    while true
      if @group_by_angle[los][1].size > 0
        as = @group_by_angle[los][1].shift
        @death_number += 1
        as.die(time_of_death: death_number)
        @los = (los + 1) % @group_by_angle.size
        vaporized << [as.x, as.y]
        break
      end
      @los = (los + 1) % @group_by_angle.size
    end
    as
  end

  def vaporize
    while num_threats > 0
      kill_next
    end
  end

  def set_asteroids
    @asteroids = {}
    (0...rows).each do |i|
      (0...cols).each do |j|
        @asteroids [[j, i]] = Asteroid.new(x:j, y:i) if (grid[i][j] == "#" && !(i == y && j == x)) #reverse coords.
      end
    end
  end

  ## also sorts by distance
  def set_angles_group
    by_angle = asteroids.values.group_by{ |as| as.angle }
    @group_by_angle = by_angle.map do |ang, asts|
      # byebug if ang == 0
      [ang, asts.sort_by{ |as| p1.distance(as) } ]
    end
    @group_by_angle.sort_by!{|g| g[0]}
  end

  def num_threats
    asteroids.count{ |k,v| v.alive? }
  end
end

class Point
  def initialize(x:, y:)
    @x = x
    @y = y
  end

  attr_reader :x, :y

  def get_angle(p2)
    v1 = Vector.new(x:0, y: -1) ## just some vector with direction north of point. for angle to count clockwise.
    v2 = Vector.new(x: p2.x - x, y: p2.y - y)
    ang = v1.get_angle(v2)
    ang = (2 * Math::PI - ang) if p2.x < x
    ang
  end

  def distance(p2)
    Vector.new(x: p2.x - x, y: p2.y - y).mag
  end
end

class Asteroid < Point
  def initialize(x:, y:)
    @alive = true
    @time_of_death = nil
    super(x:x, y:y)
  end

  attr_reader :angle, :time_of_death, :alive

  ## po is reference point
  def set_angle(po)
    @angle = po.get_angle(self)
  end

  def die(time_of_death:)
    @time_of_death = time_of_death
    @alive = false
  end

  def alive?
    alive
  end
end

class Vector
  def initialize(x:, y:)
    @x = x
    @y = y
  end

  attr_reader :x, :y

  def dotp(v2)
    (x * v2.x) + (y * v2.y)
  end

  def mag
    Math.sqrt((x*x) + (y*y))
  end

  def get_angle(v2)
    dp = dotp(v2)
    Math.acos(Float(dp) / (mag * v2.mag))
  end
end