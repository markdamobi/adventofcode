require './helper'

class Maze
  def initialize()
    @grid = File.readlines("p13_input.txt").map{ |i| i.chomp}
    # @grid = File.readlines("p13_test.txt").map{ |i| i.chomp}
    @row_size = @grid.size 
    @col_size = @grid[0].size
    set_carts
    fix_grid
    # find_crash
  end 

  attr_reader :grid, :row_size, :col_size, :carts

  def tick
    carts.sort_by{|id, dets| dets[:pos][0] }.each do |id,dets|
      move_cart(id)
    end
    carts
  end

  def find_crash
    while true 
      tick
      crash = crash?
      if crash
        p crash
        break 
      end
    end
  end

  def move_cart(id)
    x,y = carts[id][:pos]
    val = carts[id][:val]
    if val == '^'
      @carts[id][:pos] = [x-1,y]
      up_val = grid[x-1][y]
      if up_val == '/'
        @carts[id][:val] = ">"
      elsif up_val == '|'
        ## same dir
      elsif up_val == '+'
        @carts[id][:val] = get_inter_val(@carts[id][:intersection].next, val)
      elsif up_val == "\\"
        @carts[id][:val] = "<"
      end
    elsif val == 'v'
      @carts[id][:pos] = [x+1,y]
      down_val = grid[x+1][y]
      if down_val == '/'
        @carts[id][:val] = "<"
      elsif down_val == '|'
        ## same dir
      elsif down_val == '+'
        @carts[id][:val] = get_inter_val(@carts[id][:intersection].next, val)
      elsif down_val == "\\"
        @carts[id][:val] = ">"
      end
    elsif val == '<'
      @carts[id][:pos] = [x,y-1]
      left_val = grid[x][y-1]
      if left_val == '/'
        @carts[id][:val] = "v"
      elsif left_val == '-'
        ## same dir
      elsif left_val == '+'
        @carts[id][:val] = get_inter_val(@carts[id][:intersection].next, val)
      elsif left_val == "\\"
        @carts[id][:val] = "^"
      end
    elsif val == '>'
      @carts[id][:pos] = [x,y+1]
      right_val = grid[x][y+1]
      if right_val == '/'
        @carts[id][:val] = "^"
      elsif right_val == '-'
        ## same dir
      elsif right_val == '+'
        @carts[id][:val] = get_inter_val(@carts[id][:intersection].next, val)
      elsif right_val == "\\"
        @carts[id][:val] = "v"
      end
    end


  end


  def set_carts
    @carts = {}
    count = 1
    (0...row_size).each do |i|
      (0..col_size).each do |j|
        if ["^", "v", "<", ">"].include? grid[i][j]
          @carts[count] = {}
          @carts[count][:pos] = [i,j]
          @carts[count][:val] = grid[i][j]
          @carts[count][:intersection] = init_intersection
          count += 1
        end
      end
    end
  end

  def init_intersection
    [:left, :straight, :right].cycle
  end

  def get_inter_val(direction, curr_val)
    vals = ["^", ">", "v", "<"]
    i = vals.index curr_val
    if direction == :left
      return vals[(i-1)%4]
    elsif direction == :straight
      curr_val
    elsif direction == :right 
      return vals[(i+1)%4]
    end 


    # vals = ["^", "<", "v", ">"]
    # i = vals.index v
  end

  def fix_grid
    carts.each do |id, dets|
      val = dets[:val]
      x,y = dets[:pos]
      if val == "^" || val == "v"
        grid[x][y] = "|"
      elsif val == "<" || val == ">"
        grid[x][y] = "-"
      end
    end
  end 

  def crash?
    carts.keys.each_cons(2) do |id1,id2|
      return carts[id1][:pos] if carts[id1][:pos] == carts[id2][:pos]
    end
    nil
  end

  def part1()

    input.each do |line|

    end


    
  end

end