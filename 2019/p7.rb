require 'byebug'
def run1(file: 'p7.txt')
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  amplifiers(list)
end

def run2(file: 'p7.txt')
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  amplifiers2(list)
end

def amplifiers(list)
  max_t = -99999999

  [0,1,2,3,4].permutation(5).each do |a,b,c,d,e|
    input = 0
    l = list.dup
    prog = Program.new(list: l, orig_input: [a, input])
    input = prog.compute

    l = list.dup
    prog = Program.new(list: l, orig_input: [b, input])
    input = prog.compute

    l = list.dup
    prog = Program.new(list: l, orig_input: [c, input])
    input = prog.compute

    l = list.dup
    prog = Program.new(list: l, orig_input: [d, input])
    input = prog.compute

    l = list.dup
    prog = Program.new(list: l, orig_input: [e, input])
    output = prog.compute

    if(output > max_t)
      max_t = output
    end

  end
  max_t
end


def amplifiers2(list)
  max_t = -99999999

  # [5,6,7,8,9].permutation(5).each do |a,b,c,d,e|
  [[9,8,7,6,5]].each do |a,b,c,d,e|
    # input = 0
    l1 = list.dup
    l2 = list.dup
    l3 = list.dup
    l4 = list.dup
    l5 = list.dup


    ## first round.
    prog1 = Program.new(list: l1, orig_input: [a, 0])
    input = prog1.compute

    prog2 = Program.new(list: l2, orig_input: [b, input])
    input = prog2.compute

    prog3 = Program.new(list: l3, orig_input: [c, input])
    input = prog3.compute

    prog4 = Program.new(list: l4, orig_input: [d, input])
    input = prog4.compute

    prog5 = Program.new(list: l5, orig_input: [e, input])
    input = prog5.compute



    while(true)
      input = prog1.compute(input: [input])
      input = prog2.compute(input: [input])
      input = prog3.compute(input: [input])
      input = prog4.compute(input: [input])
      input = prog5.compute(input: [input])

      break if input == nil
      if(input > max_t)
        max_t = input
      end
    end

  end
  max_t
end

class Opcode
  def initialize(pointer: 0, code: , input1: , input2: nil, p1: 0, p2: 0, p3: 0, list:, orig_input: nil)
    @code = code
    @input1 = input1
    @input2 = input2
    @p1 = p1
    @p2 = p2
    @p3 = p3
    @list = list
    @pointer = pointer
    @orig_input = orig_input

    set_output_address
    resolve_parameter
  end

  attr_reader :code, :input1, :input2, :p1, :p2, :p3, :list, :pointer, :output_address, :orig_input

  def resolve_parameter
    if [1,2,3,4,5,6,7,8].include?(code)
      @input1 = list[input1] if p1 == 0
      @input2 = list[input2] if ((input2 != nil) && (p2 == 0))
    end
  end

  def perform
    case code
    when 1
      add
    when 2
      multiply
    when 3
      three
    when 4
      four
    when 5
      jump_if_true
    when 6
      jump_if_false
    when 7
      less_than
    when 8
      equals
    end
  end

  def set_output_address
    if [1, 2, 7, 8].include? code
      @output_address = pointer + 3
    elsif code == 3
      @output_address = input1
    end
  end

  def add
    list[list[output_address]] = input1 + input2
    @pointer += 4
  end

  def multiply
    list[list[output_address]] = input1 * input2
    @pointer += 4
  end

  def three
    list[output_address] = orig_input.shift
    @pointer += 2
  end

  def four
    # puts input1
    @pointer += 2
    input1
  end

  def jump_if_true
    if input1 != 0
      @pointer = input2
    else
      @pointer += 3
    end
  end

  def jump_if_false
    if input1 == 0
      @pointer = input2
    else
      @pointer += 3
    end
  end

  def less_than
    if input1 < input2
      list[list[output_address]] = 1
    else
      list[list[output_address]] = 0
    end
    @pointer += 4
  end

  def equals
    if input1 == input2
      list[list[output_address]] = 1
    else
      list[list[output_address]] = 0
    end
    @pointer += 4
  end
end


class Program
  def initialize(list:, orig_input: [], pointer: 0)
    @list = list
    @pointer = pointer
    @orig_input = orig_input
  end

  attr_reader :list, :pointer, :orig_input

  def compute(input: nil)
    if input != nil
      @orig_input += input
    end

    x = nil
    new_code = get_code
    while(new_code != 99)
      x = tick
      new_code = get_code
      break if new_code == 4
    end
    x
  end

  def tick
    inst = list[pointer]
    imp = ("%4d"%inst).chars.map(&:to_i)
    code = imp[-1]
    p1 = imp[-3]
    p2 = imp[-4]
    input1 = list[pointer + 1]
    input2 = nil
    input2 = list[pointer + 2] if [1,2,5,6,7,8].include?(code)

    opcode = Opcode.new(pointer: pointer,
                        code: code,
                        input1: input1,
                        input2: input2,
                        p1: p1,
                        p2: p2,
                        list: list,
                        orig_input: orig_input)
    p opcode
    ret_val = opcode.perform
    @pointer = opcode.pointer
    ret_val
  end

  def get_code
    inst = list[pointer]
    imp = ("%4d"%inst).chars.map(&:to_i)
    code = imp[-2..-1].join.to_i
  end

end