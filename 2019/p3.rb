### Need to clean this up at some point. there's some repeated logic and some
### things aren't super clear.

def run1
  data = File.readlines('p3.txt')
  w1 = Wire.new(data[0].chomp).tap{ |w| w.generate_points }
  w2 = Wire.new(data[1].chomp).tap{ |w| w.generate_points }
  w1.min_intersection_distance(w2)
end


def run2
  data = File.readlines('p3.txt')
  w1 = Wire.new(data[0].chomp).tap{ |w| w.generate_points }
  w2 = Wire.new(data[1].chomp).tap{ |w| w.generate_points }
  intersects = w1.intersections(w2)[1..-1] #ignore [0,0]
  w1.init_h(intersects)
  w2.init_h(intersects)
  w1.generate_intersects_step
  w2.generate_intersects_step

  Wire.compare_intersects(w1, w2)
end

class Wire
  def initialize(path)
    @moves = path.split(",")
    @x = 0
    @y = 0
    @points = [[0,0]]
    @steps = 0
    @h = {}
  end

  attr_reader :x, :y, :points, :moves, :h, :steps

  def self.compare_intersects(w1, w2)
    w1.h.keys.map{|k| w1.h[k] + w2.h[k]}.min
  end

  def generate_points
    moves.each{ |m| move(m) }
  end

  def generate_intersects_step
    reset
    moves.each{ |m| move2(m) }
  end

  def reset
    @x = 0
    @y = 0
    @points = [[0,0]]
    steps = 0
  end

  def move(m)
    n = m[1..-1].to_i
    if(m.start_with?("R"))
      n.times do
        @x += 1
        @points << [x, y]
      end
    elsif(m.start_with?("L"))
      n.times do
        @x -= 1
        @points << [x, y]
      end
    elsif(m.start_with?("U"))
      n.times do
        @y += 1
        @points << [x, y]
      end
    elsif(m.start_with?("D"))
      n.times do
        @y -= 1
        @points << [x, y]
      end
    end
  end

  def move2(m)
    n = m[1..-1].to_i
    if(m.start_with?("R"))
      n.times do
        @x += 1
        @points << [x, y]
        @steps += 1
        resolve_int(x, y)
      end
    elsif(m.start_with?("L"))
      n.times do
        @x -= 1
        @points << [x, y]
        @steps += 1
        resolve_int(x, y)
      end
    elsif(m.start_with?("U"))
      n.times do
        @y += 1
        @points << [x, y]
        @steps += 1
        resolve_int(x, y)
      end
    elsif(m.start_with?("D"))
      n.times do
        @y -= 1
        @points << [x, y]
        @steps += 1
        resolve_int(x, y)
      end
    end
  end

  ## update steps in hash only the first time we see intersection.
  def resolve_int(x, y)
    if (h.has_key?([x, y]) && h[[x,y]] == 0)
      @h[[x, y]] = steps
    end
  end

  def init_h(intersects)
    intersects.each{ |inter| @h[inter] = 0 }
  end

  def intersections(other_wire)
    points & other_wire.points
  end

  def min_intersection_distance(other_wire)
    intersections(other_wire).map{ |x,y| x.abs + y.abs }.sort[1]
  end
end