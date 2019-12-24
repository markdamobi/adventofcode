require 'byebug'

def run1(file: 'p24.txt')
  data = File.readlines(file).map{ |l| l.chomp.strip.split("") }
  eris = Eris.new(grid: data)
  eris.propagate
end

class Eris
  def initialize(grid:)
    @grid = grid
    @seen = Set.new([state])
    @x = grid.size
    @y = grid[0].size
  end

  attr_reader :grid, :dup_grid, :seen, :x, :y

  def propagate
    while true
      tick
      new_state = state
      break if seen.include?(new_state)
      @seen << new_state
    end
    get_bio_diversity
  end

  def get_bio_diversity
    su = 0
    state.chars.each_with_index do |s, i|
      if s == "#"
        su += 2**(i)
      end
    end
    su
  end

  def tick
    set_dup_grid
    (0...x).each do |i|
      (0...y).each do |j|
        tick_point(i, j)
      end
    end
  end

  def set_dup_grid
    @dup_grid = []
    grid.each{ |row| @dup_grid << row.dup }
  end

  def tick_point(i, j)
    if should_die?(i,j)
      @grid[i][j] = "."
    elsif should_become_infested?(i,j)
      @grid[i][j] = "#"
    end
  end

  def num_adj_bugs(i, j)
    [(i-1) >= 0 && dup_grid.dig(i-1, j),
     (j+1) < y && dup_grid.dig(i, j+1),
     (i+1) < x && dup_grid.dig(i+1, j),
     (j-1) >= 0 && dup_grid.dig(i, j-1),
  ].count{ |v| v == "#" }
  end

  def neighbors(i, j)
    [i-1]
  end

  def state
    grid.flatten.join
  end

  def bug?(i,j)
    dup_grid.dig(i, j) == "#"
  end

  def space?(i,j)
    dup_grid.dig(i, j) == "."
  end

  def should_die?(i, j)
    bug?(i, j) && (num_adj_bugs(i, j) != 1)
  end

  def should_become_infested?(i, j)
    space?(i,j) && [1,2].include?(num_adj_bugs(i,j))
  end

  def display
    grid.each{ |row| puts row.join }
    nil
  end
end