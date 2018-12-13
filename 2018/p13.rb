require './helper'

class Maze
  def initialize(filename="p13_input.txt")
    # @grid = File.readlines("p13_input.txt").map{ |i| i.chomp}
    # @grid = File.readlines("p13_test.txt").map{ |i| i.chomp}
    # @grid = File.readlines("p13_test2.txt").map{ |i| i.chomp}
    @grid = File.readlines(filename).map{ |i| i.chomp}

    @row_size = @grid.size 
    @col_size = @grid[0].size
    set_carts
    fix_grid
  end 

  attr_reader :grid, :row_size, :col_size, :carts

  def show
    g = grid.deep_dup
    carts.each do |id, dets|
      x,y = dets[:pos]
      if g[x][y].in? ["^", "v", "<", ">"] 
        g[x][y] = "X"
      else
        g[x][y] = dets[:val]
      end
    end
    # byebug
    puts g.join("\n")
  end 

  def tick
    carts.sort_by{|id, dets| dets[:pos] }.each do |id,dets|
      move_cart(id)
    end
    carts
  end

  def movee
    while true 
      carts.sort_by{|id, dets| dets[:pos] }.each do |id,dets|
        move_cart(id)
        if carts.select{|cid, cdets| cdets[:pos] == carts[id][:pos]}.size > 1
          p carts[id][:pos].reverse ## my cordinate is flipped. 
          return
        end
      end
    end
  end

  def movee2
    loop do
      tick 
      remove_crash
      if carts.keys.size == 1
        p carts.values
        break
      end

    end
  end

  def remove_crash
    crashes = carts.keys.combination(2).select{|id1, id2| carts[id1][:pos] == carts[id2][:pos]}.flatten.uniq
    crashes.each{|id| @carts.delete(id)}
  end

  #### NEEDS REFACTORING!
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
    ["left", "straight", "right"].cycle
  end

  def get_inter_val(direction, curr_val)
    vals = ["^", ">", "v", "<"]
    i = vals.index curr_val
    if direction == "left"
      return vals[(i-1)%4]
    elsif direction == "straight"
      return curr_val
    elsif direction == "right" 
      return vals[(i+1)%4]
    end 
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
    carts.keys.combination(2) do |id1,id2|
      return carts[id1][:pos] if carts[id1][:pos] == carts[id2][:pos]
    end
    nil
  end


end