def run1
  data = File.readlines('p3.txt')
  w1 = Wire.new(data[0].chomp).tap{ |w| w.generate_points }
  w2 = Wire.new(data[1].chomp).tap{ |w| w.generate_points }
  w1.min_intersection_distance(w2)
end

class Wire
  def initialize(path)
    @moves = path.split(",")
    @x = 0
    @y = 0
    @points = [[0,0]]
  end

  attr_reader :x, :y, :points, :moves

  def generate_points
    moves.each{ |m| move(m) }
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

  def intersections(other_wire)
    points & other_wire.points
  end

  def min_intersection_distance(other_wire)
    intersections(other_wire).map{ |x,y| x.abs + y.abs }.sort[1]
  end
end