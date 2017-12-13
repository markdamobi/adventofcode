## get integer in bottom corner with coordinate (-n,-n)
def bottom_corner(n)
  if n == 0
    return 1
  elsif n == 1
    return 7
  else
    a_prev = 7
    a_curr = 0
    2.upto(n) do |i|
      a_curr = a_prev + 6 + (8 * (i-1))
      a_prev = a_curr
    end

  end
  a_curr
end

class Mover
  attr_accessor :x,:y

  def initialize(xcoord=0,ycoord=0)
    @x = xcoord
    @y = ycoord
  end

  def move(direction)
    if direction == :right
      @x += 1
    elsif direction == :up
      @y += 1
    elsif direction == :left
      @x -= 1
    elsif direction == :down
      @y -= 1
    end
  end

  def coord
    [x,y]
  end
end

def getcoord(num)
  origin = get_origin(num)
  origin_num = bottom_corner(origin)
  curr_position = origin_num
  mover = Mover.new(-origin, -origin)
  return mover.coord if num == origin_num
  (2*origin + 1).times do
    mover.move(:right)
    curr_position +=1
    return mover.coord if curr_position == num
  end
  (2*origin + 1).times do
    mover.move(:up)
    curr_position +=1
    return mover.coord if curr_position == num
  end
  (2*origin + 2).times do
    mover.move(:left)
    curr_position +=1
    return mover.coord if curr_position == num
  end
  (2*origin + 2).times do
    mover.move(:down)
    curr_position +=1
    return mover.coord if curr_position == num
  end

end

def get_origin(num)
  origin = 0
  i = 0
  while true
    if bottom_corner(i+1) > num
      origin = i
      break
    end
    i += 1
  end
  origin
end

def get_d(num)
  num_coord = getcoord(num)
  num_coord.reduce(0){|acc,c| acc + c.abs}
end


##get_d(326)
