require './helper'

class Velocity
  def initialize(filename="p10_input.txt")
    @filename = filename
    read_file
    @time_elapsed = 0
  end

  attr_reader :filename, :points, :time_elapsed

  def read_file
    @points = []
    lines = File.readlines(filename).map{ |i| i.chomp}
    lines.each do |l|
      @points << get_point(l)
    end
  end

  def tick
    @points.each{|pt| pt.tick}
    @time_elapsed += 1
  end

  def bounds
    minx, maxx = points.map(&:x).minmax
    miny, maxy = points.map(&:y).minmax
    {x: [minx, maxx], y: [miny, maxy]}
  end

  def show
    points_cords = points.map{|pt| [pt.x, pt.y]}
    gridx, gridy = 160, 60 ## this is just some arbitrary size that assumes message should be within bounds of my screen. 
    bs = bounds
    x1,x2 = bs[:x]
    y1,y2 = bs[:y]

    if x2 - x1 > gridx || y2 - y1 > gridy 
      # puts "not within range"
      # do nothing if all points not within range. 
      return nil
    end

    (y1..y2).each do |y|
      (x1..x2).each do |x|
        if points_cords.include?  [x,y]
          print "#"
        else
          print "."
        end
      end
      puts "\n"
    end
    true
  end


  def show_when_in_range
    loop do 
      tick 
      return if show ## just need to display after each tick within range to manually inspect output. 
    end
  end


  def get_point(line)
    md = line.match(/.*<(.*), (.*)>.*<(.*), (.*)>/)
    x,y,vx,vy = md.values_at(1,2,3,4).map(&:to_i)
    Point.new(x,y,[vx,vy])
  end

end

class Point
  def initialize(x,y, v)
    @x = x
    @y = y
    @v = v
  end

  attr_reader :x, :y, :v

  def tick
    @x += v[0]
    @y += v[1]
  end
end


#############
# call show_when_in_range until something shows up. then call it some more times as needed until output is readable. 