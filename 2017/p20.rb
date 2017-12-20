require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip }
end

class SomeClass
  attr_reader :something

  def initialize(x)

  end
end


def run1
  # s = SomeStuff.new(read_file('2017/p20_test.txt'))
  s = SomeStuff.new(read_file('2017/p20_input.txt'))
  s.some_method
end
