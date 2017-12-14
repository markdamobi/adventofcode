class Mover
  attr_accessor :x,:y, :cannot_move_right, :cannot_move_left

  def initialize(xcoord=0,ycoord=0)
    @x = xcoord
    @y = ycoord
  end

  def move(direction)
    if direction == :right
      if y <= 0 && x <= y.abs && x >= y
        @x += 1
        return true
      else
        @cannot_move_right = true
      end
    elsif direction == :up
      if x > 0 && x > y && cannot_move_right
        @y += 1
        @cannot_move_right = false
        return true
      end
    elsif direction == :left
      if y > 0 && x > -y && x <= y
        @x -= 1
        return true
      else
        @cannot_move_left = true
      end
    elsif direction == :down
      if x < 0 && x < y && cannot_move_left
        @y -= 1
        @cannot_move_left = false
        return true
      end
    end
    return false
  end

  def step
    (move(:right) || move(:up) || move(:left) || move(:down))
    # coord
  end

  def coord
    [x,y]
  end
end
