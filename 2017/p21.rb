require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip.split(" => ") }
end

class Art
  attr_reader :board, :new_board, :rules

  def initialize(rules)
    @board = [".#.","..#", "###"].map{|s| s.split("")}
    @new_board = []
    @rules = rules.to_h
    # rules.each{|rule| @rules[rule[0]] = rule[1]}

  end

  # def flip(piece)
  #   piece.map!{|part| part.reverse}
  #   piece
  # end
  #
  # def stringify(arr)
  #   arr.map{|ar| ar.join("")}.join("/")
  # end
  #
  # def rotate(piece)
  #   piece.map!{|part| part.reverse}
  #   piece
  # end
  #
  # def get_piece(y1,x1,x2)
  #   piece = []
  #   depth = x2 - x1
  #   0.upto(depth).each do |i|
  #     piece << board[y1+i][x1..x2]
  #   end
  # end

  def enhance
    block_size = board.size.even? ? 2 : 3
    num_of_positions = ( board.size / block_size )^2
    @new_board = Array.new((board.size / block_size) * (block_size+1) ){Array.new}

    num_of_positions.each do |pos|
      block = get_block(block_size, pos)
      enhanced_block = enhance_block(block)
      add_to_board(enhanced_block, pos)
    end

    @board = new_board.deep_dup
  end

  def enhance_block(block)

  end

  def rotate_array(arr)
    new_arr = []
    (0...arr[0].length).each do |i|
      new_arr << (0...arr.length).map{|j| arr[arr.length - 1 - j][i]}
    end
    new_arr
  end

  ## flips left to right.
  def flip(arr)
    arr.map{|part| part.reverse}
  end

  def stringify(arr)
    arr.map{|ar| ar.join("")}.join("/")
  end

  def arrayify(str)
    str.split("/").map{|l| l.split("")}
  end

  def orientations(arr)
    r1 = rotate_array(arr)
    r2 = rotate_array(r1)
    r3 = rotate_array(r2)
    f = flip(arr)
    r2f = flip(r2)
    [r1,r2,r3,f,r2f]
  end

  def get_block(block_size, pos)
    block = Array.new(block_size){Array.new}
    start_y, start_x = get_start_coord(block_size, board.size, pos)
    num_squares = (block_size)^2
    num_squares.times do |i|
      curr_y = (i / block_size) + start_y
      curr_x = (i % block_size) + start_x
      block[i / block_size][i % block_size] = board[curr_y][curr_x]
    end
  end

  ## this assumes that board is prepared and ready to accept aditions.
  def add_to_board(block, pos)
    start_y, start_x = get_start_coord(block.size, new_board.size, pos)
    num_squares = (block.size)^2
    num_squares.times do |i|
      curr_y = (i / block.size) + start_y
      curr_x = (i % block.size) + start_x
      @new_board[curr_y][curr_x] = block[i / block.size][i % block.size]
    end
  end

  def get_start_coord(block_size, board_size, pos)
    quotient = board_size / block_size
    start_y = (pos / quotient) * block_size
    start_x = (pos % quotient) * block_size
    [start_y, start_x]
  end

  def num_on; board.flatten.count("#"); end
  def num_off; board.flatten.count("."); end

  def set_rules(instructions)

  end



end


def run1
  # s = SomeStuff.new(read_file('2017/p21_test.txt'))
  art = Art.new(read_file('2017/p21_input.txt'))

  byebug
  # 5.times{art.enhance}
  # art.num_on
end
