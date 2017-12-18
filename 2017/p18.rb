require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip }
end

class Sound
  attr_reader :registers, :pointer, :frequency, :instructions

  def initialize(instructions)
    @pointer = 0
    @instructions = instructions
    @registers = {}
    ("a".."z").each{|l| @registers[l] = {val: 0}}
  end

  def snd(inst)
    register = inst.split(" ")[1]
    @frequency = @registers[register][:val]
    @pointer += 1
  end

  def set(inst)
    dir = inst.split(" ")
    register, num = dir[1], dir[2]
    @registers[register][:val] = num.to_i
    @pointer += 1
  end

  def add(inst)
    dir = inst.split(" ")
    register, r2 = dir[1], dir[2]

    if @registers[r2]
      num = @registers[r2][:val]
    else
      num = r2.to_i
    end

    @registers[register][:val] = @registers[register][:val] + num.to_i
    @pointer += 1
  end

  def mul(inst)
    dir = inst.split(" ")
    register, r2 = dir[1], dir[2]

    if @registers[r2]
      num = @registers[r2][:val]
    else
      num = r2.to_i
    end

    @registers[register][:val] = @registers[register][:val] * num.to_i
    @pointer += 1
  end

  def mod(inst)
    dir = inst.split(" ")
    register, r2 = dir[1], dir[2]

    if @registers[r2]
      num = @registers[r2][:val]
    else
      num = r2.to_i
    end

    @registers[register][:val] = @registers[register][:val] % num.to_i
    @pointer += 1
  end

  def rcv(inst)
    dir = inst.split(" ")
    register = dir[1]
    if registers[register][:val] != 0
      @recovered = @frequency
      puts frequency
    end
    @pointer += 1
  end

  def jgz(inst)
    dir = inst.split(" ")
    register, r2 = dir[1], dir[2]

    if @registers[r2]
      num = @registers[r2][:val]
    else
      num = r2.to_i
    end

    p inst
    p register
    p registers

    if (registers[register] && registers[register][:val] > 0) || (registers[register].blank? && register.to_i >0)
      @pointer += num
    else
      @pointer += 1
    end
  end

  def run_instructions
    while 0 <= pointer && pointer < instructions.length
      # p pointer
      inst = instructions[pointer]
      if inst.starts_with?("snd")
        snd(inst)
      elsif inst.starts_with?("set")
        set(inst)
      elsif inst.starts_with?("add")
        add(inst)
      elsif inst.starts_with?("mul")
        mul(inst)
      elsif inst.starts_with?("mod")
        mod(inst)
      elsif inst.starts_with?("rcv")
        rcv(inst)
      elsif inst.starts_with?("jgz")
        jgz(inst)
      end
    end
    # puts done
  end


end



#### Solutions not complete. Instructions not quite clear. 
def run1
  # s = Sound.new(read_file('2017/p18_test.txt'))
  s = Sound.new(read_file('2017/p18_input.txt'))
  # byebug
  s.run_instructions
  p s
end
