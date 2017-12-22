require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip.split("") }
end

class Infection
  attr_reader :something, :infected, :cleaned, :orientation, :y, :x, :board

  def initialize(board)
    @board = board
    @x, @y = board.size / 2, board.size / 2
    @orientation = :up
    @infected = 0
    @cleaned = 0
  end

  def move
    if current_infected?
      turn_right
      clean_node
    else
      turn_left
      infect_node
    end
    move_in_direction
  end

  def turn_right
    case orientation
    when :up
      @orientation = :right
    when :right
      @orientation = :down
    when :down
      @orientation = :left
    when :left
      @orientation = :up
    end
  end

  def turn_left
    case orientation
    when :up
      @orientation = :left
    when :left
      @orientation = :down
    when :down
      @orientation = :right
    when :right
      @orientation = :up
    end
  end

  def move_in_direction
    case orientation
    when :up
      if y == 0
        @board.unshift(Array.new(board[0].length){"."})
      else
        @y -= 1
      end
    when :left
      if x == 0
        board.length.times{|i| @board[i].unshift(".")}
      else
        @x -= 1
      end
    when :down
      if y == board.size - 1
        @board.append(Array.new(board[0].length){"."})
      end
      @y += 1
    when :right
      if x == board[0].size - 1
        board.length.times{|i| @board[i].append(".")}
      end
      @x += 1
    end
  end


  def clean_node
    @board[y][x] = "."
    @cleaned += 1
  end

  def infect_node
    @board[y][x] = "#"
    @infected += 1
  end

  def current_infected?
    board[y][x] == "#"
  end

end


def run1
  # s = SomeStuff.new(read_file('2017/p22_test.txt'))
  virus = Infection.new(read_file('2017/p22_input.txt'))
  byebug
end
