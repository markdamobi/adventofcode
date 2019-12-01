require './helper'

class P1
  def initialize(filename="p1.txt")
    @filename = filename
    read_file
  end

  attr_reader :filename

  def read_file
    lines = File.readlines(filename).map{ |i| process_line(i) }
    lines.reduce(:+)
  end

  def process_line(l)
    (l.chomp.to_i / 3) - 2
  end
end
