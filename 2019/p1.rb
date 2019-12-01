require './helper'

class P1
  def initialize(filename="p1.txt")
    @filename = filename
  end

  attr_reader :filename

  def read_file1
    lines = File.readlines(filename).map{ |i| process_line(i) }
    lines.reduce(:+)
  end

  def process_line(l)
    (l.chomp.to_i / 3) - 2
  end
end


def process(n)
  (n / 3) - 2
end

def process_item(i)
  rs = 0
  x = i
  while((x = process(x)) > 0)
    rs += x
  end
  rs
end

def run2
  data = File.readlines('p1.txt').map{ |i| i.chomp.strip.to_i }
  data.map{|i| process_item(i)}.sum
end