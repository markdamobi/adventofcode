def read_arr(file)
  File.readlines(file).map{|l| l.strip.to_i}
end

class Mover
  attr_accessor :position
  attr_reader :offsets

  def initialize(input_offsets)
    @offsets = input_offsets
    @position = 0
  end

  def jump
    return false if out_of_bounds?
    step = offsets[position]
    new_pos = position + step
    @offsets[position] += 1
    @position = new_pos
    true
  end

  def escape
    num_steps = 0
    return num_steps if out_of_bounds?
    until out_of_bounds?
      jump
      num_steps += 1
    end
    num_steps
  end

  def out_of_bounds?
    # position < 0 || position > offsets.length-1
    position / offsets.length != 0
  end

end


def run
  input = read_arr('2017/p5_input.txt')
  m = Mover.new(input)
  m.escape
end
