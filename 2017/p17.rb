require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip }
end

class Buffer
  attr_reader :curr_pos, :step, :buffer, :curr_value

  def initialize(step = 3)
    @step = step
    @curr_pos = 0
    @buffer = [0]
    @curr_value = 1
  end

  def move
    new_pos = curr_pos + step
    @buffer[new_pos + 1] = curr_value
    @curr_pos = curr_value
    @curr_value += 1
  end
end

#### code not working. stil in progress. 
def run1
  # s = SomeStuff.new(read_file('2017/p16_txt.txt'))
  bb = Buffer.new()
  byebug
  2017.times{bb.move}
  bb.buffer
end
