require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip }
end

class Art
  attr_reader :board, :new_board

  def initialize(x)
    @board = []
    @new_board = []
    @start_state = [".#.","..#", "###"]
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
    @new_board = Array.new(board.size / block_size){Array.new}

    num_of_positions.each do |pos|
      block = get_block(block_size, pos)
      enhanced_block = enhance_block(block)
      add_to_board(enhanced_block, pos)
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

end


def run1
  # s = SomeStuff.new(read_file('2017/p21_test.txt'))
  art = Art.new(read_file('2017/p21_input.txt'))
  5.times{art.enhance}
  art.num_on
end
