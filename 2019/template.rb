require './helper'

class SomeClass
  def initialize(filename="pX.txt")
    @filename = filename
    read_file
  end

  attr_reader :filename

  def read_file
    lines = File.readlines(filename).map{ |i| process_line(i) }
    ## some additional manupulation of lines here.
  end

  ## code to parse eachline.
  def process_line(l)

  end
end

