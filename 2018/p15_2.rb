require './helper'
# require './graph_helper'
# require './graph_helper2'
# require './graph_helper3'
require './graph_helper4'

## graph_helper2 is an attempt to improve performance of shortest path search. didn't work. 
## graph_helper3 improves 2 by not computing shortests paths once all open sqs have been accounted for.

class Combat2
  def initialize(filename="p15_input.txt")
    @filename = filename
    read_file
    @num_rounds = 0
  end

  attr_reader :filename, :grid, :units, :xlim, :ylim, :elves

  def read_file
    lines = File.readlines(filename).map{ |i| i.chomp}
    @grid = []
    @units = []
    lines.each_with_index do |l,i|
      row = []
      l.split("").each_with_index do |val,j|
        if val.in? ["G", "E"]
          cell = Unit.new(i,j,val)
          @units << cell 
        else 
          cell = val
        end
        row << cell
      end
      @grid << row
    end
    @xlim = @grid.size 
    @ylim = @grid.first.size 

    @elves = units.select{|u| u.elf?}
  end

  def elves_win 
    e_attack = 4
    while true 
      read_file
      elves.each {|el| el.set_power(e_attack)}
      outcome = process 
      if outcome != -1
        puts e_attack
        puts outcome
        break
      end
      e_attack += 1
    end
    outcome
  end



  def process 
    @num_rounds = 0

    loop do  
      val = tick 
      if val == true 
        @num_rounds += 1
      elsif val == false
        break
      elsif val == "E"
        return -1
      end
    end

    v = @num_rounds * units.select(&:alive?).map(&:hits).reduce(:+) 
  end

  def tick
    units.select{|u| u.alive?}.sort_by{|u| u.pos}.each do |u|
      killed = nil
      next unless u.alive?
      targets = targets(u)
      return false unless targets.present?
      if in_range_of_target?(u)
        killed = attack(u)
      else
        op_sqs_near_tg = opensqs_in_range_of_targets(u)
        if op_sqs_near_tg.present?
          sq = get_location_to_move(u, op_sqs_near_tg)
          move(u, sq)

          if in_range_of_target?(u)
            killed = attack(u)
          end

        end
      end
      if killed == "E"
        return "E"
      end
    end

    true
  end

  def show 
    grid.each do |row|
      row.each do |v|
        if v.is_a? Unit 
          print v.val
        else 
          print v
        end
      end
      print "\n"
    end
    nil
  end

  def show_hits 
    p units.select(&:alive?).map{|u| [u.val, u.hits]}
  end

  def move(unit, sq)
    return unless sq.present? 
    x,y = sq 
    @grid[x][y], @grid[unit.x][unit.y] = unit, "."
    unit.move_to(x,y)

  end

  def get_location_to_move(unit, sqs_in_range)
    vertices = get_vertices(unit) ## should send in only open vertices. 
    source = unit.pos 
    edges = get_edges(vertices)

    # g = Graph.new(unit.pos, vertices, edges)
    # g2 = Graph2.new(unit.pos, vertices, edges)
    # g = Graph3.new(unit.pos, vertices, edges, sqs_in_range)
    # puts "before graph"
    g = Graph4.new(unit.pos, vertices, edges, sqs_in_range)
    # puts "after graph"
    # byebug
    reachable = sqs_in_range.select{ |x,y| [x,y].in?(g.ss) }

    return nil unless reachable.present?

    dists = g.d.select{|vertex, dist| vertex.in?(reachable)}

    min_dist = dists.map{|sq, d| d}.min
    allowed_max = xlim * ylim

    return if min_dist > allowed_max

    min_sqs = dists.select{|sq, d| d == min_dist}.sort_by{|sq, d| sq}


    min_sq = min_sqs.first[0] 

    neighbors = unit.neighbors.select{|n| grid[n[0]][n[1]] == "."}
    # byebug
    neighbors.map{|n| [n, Graph4.new(n, vertices, edges.reject{|e| e.include?(source)}, reachable ).d[min_sq] + 1] }.select{|n,d| d == min_dist}.sort_by{|n,d| n}.first[0]
    # neighbors.map{|n| [n, Graph3.new(n, vertices, edges.reject{|e| e.include?(source)}, reachable ).d[min_sq] + 1] }.select{|n,d| d == min_dist}.sort_by{|n,d| n}.first[0]
    # neighbors.map{|n| [n, Graph2.new(n, vertices, edges.reject{|e| e.include?(source)} ).d[min_sq] + 1] }.select{|n,d| d == min_dist}.sort_by{|n,d| n}.first[0]
    # neighbors.map{|n| [n, Graph.new(n, vertices, edges.reject{|e| e.include?(source)} ).d[min_sq] + 1] }.select{|n,d| d == min_dist}.sort_by{|n,d| n}.first[0]
  end


  ## open slots. 
  def open_squares
    sqs = []
    (0..xlim-1).each do |i|
      (0..ylim-1).each do |j|
        sqs << [i, j] if grid[i][j] == "."
      end
    end
    sqs
  end

  def get_vertices(unit) 
    [unit.pos] + open_squares 
  end 

  def get_neighbors(x,y)
    [[x-1,y], [x+1,y], [x, y-1], [x,y+1]]
  end

  def get_edges(vertices) 
    edges = []
    vertices.each do |v|
      neighbors = get_neighbors(*v)
      neighbors.each do |neighbor|
        edges << [v, neighbor].sort_by{ |v1| v1} if grid[neighbor[0]][neighbor[1]] == "."
      end
    end

    edges.uniq
  end

  def attack(unit)
    tgs = targets_in_range(unit)
    return unless tgs.present?


    tg_to_attack = tgs.sort_by{|tg| [tg.hits, tg.x,tg.y]}.first  
    unit.attack(tg_to_attack)

    if tg_to_attack.dead?
      remove(tg_to_attack)
      return "#{tg_to_attack.val}" if tg_to_attack.elf?
    end

  end

  def remove(unit)

    @grid[unit.x][unit.y] = "."
    unit.move_to(-1,-1)
  end

  def targets_in_range(unit)
    targets(unit).select{|tg| unit.neighbor?(tg)}
  end

  def targets(unit)
    units.select{|u| u.alive? && unit.enemy?(u)}
  end

  def opensqs_in_range_of_targets(unit)
    #adjacent to target 
    #not a wall. 
    sqs = targets(unit).map(&:neighbors).flatten(1).uniq.select{|x,y| grid[x][y] == "."}
    sqs
  end

  def in_range_of_target?(unit)
    #check if unit is in range of any target
    targets_in_range(unit).any?
  end
end




class Unit
  def initialize(x,y,val)
    @id = [x,y].join.to_i
    @x = x 
    @y = y 
    @val = val
    @power = 3 
    @hits = 200 
  end

  attr_reader :x, :y, :val, :power, :hits 

  def dead?
    hits <= 0
  end

  def elf?
    val == "E"
  end


  def alive?
    !dead?
  end

  def enemy?(other_unit)
    (val == "G" && other_unit.val == "E") || (val == "E" && other_unit.val == "G")
  end

  def move_to(x1,y1)
    @x, @y = x1, y1
  end

  def pos 
    [x,y]
  end

  def attack(other_unit)
    other_unit.set_hit(other_unit.hits - power)
  end

  def set_hit(new_hit)
    @hits = new_hit
  end

  def set_power(new_power)
    @power = new_power
  end

  def neighbor?(other_cell)
    (y == other_cell.y && (x - other_cell.x).abs == 1) || (x == other_cell.x && (y - other_cell.y).abs == 1)
  end

  def neighbors
    [[x-1,y], [x+1,y], [x, y-1], [x,y+1]]
  end

end

#### NOTE: Current approach is extremely inefficient. won't work for part 2. 
#### need better strategy instead of naive implementation of dijkstra's algorithm. 