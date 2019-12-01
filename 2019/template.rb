require './helper'

class SomeClass
  def initialize(filename="pX_input.txt")
    @filename = filename
    read_file
  end

  attr_reader :filename

  def read_file
    lines = File.readlines(filename).map{ |i| i.chomp}
    lines.each do |l|
      process_line(l)
    end
  end

  def process_line(l)

  end

end

