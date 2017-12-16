require 'active_support/all'
require 'byebug'
def read_file(file)
  File.read(file).split(',')
end

class Dance
  attr_reader :moves, :programs, :original_position

  def initialize(dance_moves)
    @moves = dance_moves
    @programs = ("a".."p").to_a
    @original_position = ("a".."p").to_a
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

  ## so inefficient. don't even think about it.
  # def billion
  #   (1000000000-1).times{dance}
  # end

  def billionth_dance
    (1000000000%get_period).times{dance}
  end

  def get_period
    c = 1
    loop do
      dance
      c += 1
      break if programs == original_position
    end
    c
  end
end


def run1
  # s = SomeStuff.new(read_file('2017/p16_test.txt'))
  d = Dance.new(read_file('2017/p16_input.txt'))
  d.programs
end

def run2
  d = Dance.new(read_file('2017/p16_input.txt'))
  d.billionth_dance
  d.programs
end
