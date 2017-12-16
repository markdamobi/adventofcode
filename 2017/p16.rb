require 'active_support/all'
require 'byebug'
def read_file(file)
  File.read(file).split(',')
end

class Dance
  attr_reader :moves, :programs

  def initialize(dance_moves)
    @moves = dance_moves
    @programs = ("a".."p").to_a
    dance
  end

  def spin(inst)
    n = inst[1..-1].to_i
    @programs = programs[-n..-1] + programs[0...-n]
  end

  def xchange(inst)
    a,b = inst[1..-1].split("/").map(&:to_i)
    @programs[a], @programs[b] = programs[b], programs[a]
  end

  def partner(inst)
    a,b = inst[1..-1].split("/")
    a_i, b_i = programs.index(a), programs.index(b)
    @programs[a_i], @programs[b_i] = b, a
  end

  def dance
    moves.each do |m|
      spin(m) if m.starts_with? "s"
      xchange(m) if m.starts_with? "x"
      partner(m) if m.starts_with? "p"
    end
  end
end


def run1
  # s = SomeStuff.new(read_file('2017/p16_test.txt'))
  d = Dance.new(read_file('2017/p16_input.txt'))
  d.programs
end
