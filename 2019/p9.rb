require 'byebug'

def run1(file: 'p9.txt', relative_base: 0)
  list = File.read(file).split(",").map{ |l| l.chomp.strip.to_i }
  list += Array.new(10000, 0)
  program = Program.new(list: list, orig_input: [1], relative_base: relative_base)
end



def d(list)

end

class Opcode
  def initialize(pointer: 0, code: , input1: , input2: nil, p1: 0, p2: 0, p3: 0, list:, orig_input: nil, relative_base: 0)
    @code = code
    @input1 = input1
    @input2 = input2
    @p1 = p1
    @p2 = p2
    @p3 = p3
    @list = list
    @pointer = pointer
    @orig_input = orig_input
    @relative_base = relative_base

    set_output_address
    resolve_parameter
  end

  attr_reader :code, :input1, :input2, :p1, :p2, :p3, :list, :pointer, :output_address, :orig_input, :relative_base

  def resolve_parameter
    if [1,2,3,4,5,6,7,8,9].include?(code)
      # @input1 = list[input1] if p1 == 0
      # @input2 = list[input2] if ((input2 != nil) && (p2 == 0))

      if p1 == 0
        @input1 = list[input1]
      elsif p1 == 2
        @input1 = list[input1 + relative_base]
      end


      if p2 == 0
        @input2 = list[input2] if (input2 != nil)
      elsif p2 == 2
        @input2 = (list[input2 + relative_base]) if (input2 != nil)
      end



      # @input1 = list[input1 + relative_base] if p1 == 2
      # @input2 = list[input2 + relative_base] if ((input2 != nil) && (p2 == 2))
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
    when 9
      nine
    end
  end

  def set_output_address
    if [1, 2, 7, 8].include? code
      @output_address = list[pointer + 3]
      @output_address += relative_base if (p3 == 2)
    elsif code == 3
      @output_address = input1
    end

  end

  def add
    list[output_address] = input1 + input2
    @pointer += 4
  end

  def multiply
    list[output_address] = input1 * input2
    @pointer += 4
  end

  def three
    list[output_address] = orig_input.shift
    @pointer += 2
  end

  def four
    @pointer += 2
    puts input1
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
      list[output_address] = 1
    else
      list[output_address] = 0
    end
    @pointer += 4
  end

  def equals
    if input1 == input2
      list[output_address] = 1
    else
      list[output_address] = 0
    end
    @pointer += 4
  end

  def nine
    @relative_base += input1
    @pointer += 2
  end
end


class Program
  def initialize(list:, orig_input: [], pointer: 0, relative_base: 0)
    @list = list
    @pointer = pointer
    @orig_input = orig_input
    @relative_base = relative_base
  end

  attr_reader :list, :pointer, :orig_input, :relative_base

  def compute(input: nil)
    if input != nil
      @orig_input += input
    end

    x = nil
    new_code = get_code
    while(new_code != 99)
      x = tick
      # break if new_code == 4
      new_code = get_code
    end
    x
  end

  def tick
    inst = list[pointer]
    imp = ("%5d"%inst).chars.map(&:to_i)
    code = imp[-1]
    p1 = imp[-3]
    p2 = imp[-4]
    p3 = imp[-5]
    byebug if p3 != 0
    input1 = list[pointer + 1]
    input2 = nil
    input2 = list[pointer + 2] if [1,2,5,6,7,8].include?(code)

    opcode = Opcode.new(pointer: pointer,
                        code: code,
                        input1: input1,
                        input2: input2,
                        p1: p1,
                        p2: p2,
                        p3: p3,
                        list: list,
                        orig_input: orig_input,
                        relative_base: relative_base)
    # p opcode
    ret_val = opcode.perform
    # p opcode
    @pointer = opcode.pointer
    @relative_base = opcode.relative_base
    ret_val
  end

  def get_code
    inst = list[pointer]
    imp = ("%4d"%inst).chars.map(&:to_i)
    code = imp[-2..-1].join.to_i
  end
end