class Mover
  attr_accessor :x,:y
  attr_reader :cannot_move_right, :cannot_move_left, :board

  def initialize(xcoord=0,ycoord=0)
    @x = xcoord
    @y = ycoord
    @board = {[0,0] => 1}
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
  end

  def coord
    [x,y]
  end

  def coord_val
    board[coord]
  end

  def neighbors
    [[x-1,y],[x+1,y],
     [x,y-1], [x, y+1],
     [x-1,y-1],[x+1,y+1],
     [x-1,y+1],[x+1,y-1]]
  end

  def step_and_update
    if step
      @board[coord] = neighbors.reduce(0){|acc, neighbor| acc + board.fetch(neighbor, 0)}
    end
  end
end


def run
  m = Mover.new(0,0)
  loop do
    m.step_and_update
    if m.coord_val > 361527
      puts m.coord_val
      break
    end
  end
end
