def run1
  data = File.readlines('p5.txt')

end

def d1(n)

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

  ## just for 1 and 2.
  def resolve_parameter
    if [1,2,3].include?(code)
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
    end
  end

  def set_output_address
    if code == 1
      @output_address = pointer + 4
    elsif code == 2
      @output_address = pointer + 4
    elsif code == 3
      @output_address = input1
    end
  end

  def add
    # puts "add -> #{input1} #{input2}"
    list[output_address] = input1 + input2
    @pointer += 4
  end

  def multiply
    # puts "multiply -> #{input1} #{input2}"
    list[output_address] = input1 * input2
    @pointer += 4
  end

  def three
    list[output_address] = orig_input
    @pointer += 2
  end

  def four
    puts input1
    @pointer += 2
  end
end

class Program
  def initialize(list:, orig_input: 1)
    @list = list
    @pointer = 0
    @orig_input = orig_input
  end

  attr_reader :list, :pointer, :orig_input

  def compute
    while(get_code != 99)
      inst = list[pointer]
      imp = ("%4d"%inst).chars.map(&:to_i)
      code = imp[-1]
      p1 = imp[-3]
      p2 = imp[-4]
      input1 = list[pointer + 1]
      input2 = nil
      input2 = list[pointer + 2] if [1,2].include?(code)

      opcode = Opcode.new(pointer: pointer,
                          code: code,
                          input1: input1,
                          input2: input2,
                          p1: p1,
                          p2: p2,
                          list: list,
                          orig_input: orig_input)
      # p opcode
      opcode.perform
      # p opcode
      @pointer = opcode.pointer
    end


  end

  def get_code
    inst = list[pointer]
    imp = ("%4d"%inst).chars.map(&:to_i)
    code = imp[-2..-1].join.to_i
  end

end