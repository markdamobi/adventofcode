require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip }
end

class Art
  attr_reader :board

  def initialize(x)
    @start_state = [".#.","..#", "###"]
  end

  def flip(piece)
    piece.map!{|part| part.reverse}
    piece
  end

  def stringify(arr)
    arr.map{|ar| ar.join("")}.join("/")
  end

  def rotate(piece)
    piece.map!{|part| part.reverse}
    piece
  end

  def get_piece(y1,x1,x2)
    piece = []
    depth = x2 - x1
    0.upto(depth).each do |i|
      piece << board[y1+i][x1..x2]
    end
  end
end


def run1
  # s = SomeStuff.new(read_file('2017/p21_test.txt'))
  s = SomeStuff.new(read_file('2017/p21_input.txt'))
  s.some_method
end
