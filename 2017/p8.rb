require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip }
end


class Directory
  attr_reader :registers, :instructions, :highest_seen
  def initialize(register_instructions)
    @instructions = register_instructions
    @registers = {}
    @highest_seen = 0
    execute_instructions
  end

  def execute_instructions
    instructions.each{|i| execute(i)}
  end
  def execute(instruction)
    a = instruction
    a.sub!("inc","+")
    a.sub!("dec","-")
    a = a.split(" ")
    # byebug
    @registers[a[0]] = @registers.fetch(a[0],0).send(a[1],a[2].to_i) if @registers.fetch(a[4],0).send(a[5], a[6].to_i)
    @highest_seen = [highest_seen, @registers.fetch(a[0],0)].max
  end
end

def run1
  # directory = Directory.new(read_file('2017/p8_test.txt'))
  directory = Directory.new(read_file('2017/p8_input.txt'))
  p directory.registers.find{ |k,v| directory.registers.values.max == v }
  p directory.highest_seen
end
