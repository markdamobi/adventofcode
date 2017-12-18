require 'active_support/all'
require 'byebug'
def read_file(file)
  File.read.strip.split(",")
end

class Hex
  attr_reader :something

  def initialize(directions)
    @directions = directions
    @origin = [0,0]

  end

  def distance(a, b)

  end
end


def run1
  # h = Hex.new(read_file('2017/p11_test.txt'))
  h = Hex.new(read_file('2017/p11_input.txt'))
  s.some_method
end
