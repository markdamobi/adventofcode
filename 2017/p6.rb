#"11 11 13 7 0 15 5 5 4 4 1 1 7 1 15 11"

class Debugger
  attr_reader :blocks, :states, :bug, :states_arr
  def initialize(mem_blocks)
    @blocks = mem_blocks
    @states = {Debugger.stringify(blocks) => true}
    @states_arr = [Debugger.stringify(blocks)]
  end

  def reallocate
    new_state = redistribute(max_block_index)
    if states[Debugger.stringify(new_state)]
      @bug = new_state
      return false
    end
    @blocks = new_state
    @states_arr << Debugger.stringify(new_state)
    @states[Debugger.stringify(new_state)] = true
    # true
  end

  def redistribute(index)
    curr_state = blocks.dup
    start_pos, start_val = max_block_index, curr_state[max_block_index]
    curr_state[start_pos] = 0
    1.upto(start_val){|i| curr_state[(start_pos+i)%curr_state.length] += 1 }
    curr_state
  end

  def max_block_index
    blocks.index(blocks.max)
  end

  def find_bug
    steps = 0
    loop do
      if reallocate
        steps += 1
      else
        break
      end
    end
    steps + 1
  end

  def loop_size
    find_bug - states_arr.index(Debugger.stringify(bug))
  end

  def self.stringify(mem_blocks)
    mem_blocks.join("-")
  end
end


def run
  d = Debugger.new([11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11])
  d.find_bug
end

def run2
  d = Debugger.new([11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11])
  d.loop_size
end
