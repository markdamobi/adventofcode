require './helper'

class Plant2
  def initialize(filename="p12_input.txt", round=20)
    @filename = filename
    read_file(round)
    @seen = {}
  end

  attr_reader :filename, :rules ,:pots, :prev_pots, :seen, :diff, :offset

  def read_file(round)
    lines = File.readlines(filename).map{ |i| i.chomp}
    @rules = {}
    @pots = lines[0].split(": ")[1].split("")

    @offset = 0 
    @diff = @pots.size - 1 ## this assumes that there's a plan at beginning and end of pot. 

    @pots = (["."]*8) + @pots + (["."]*8)

    lines[2..-1].each do |l|
      x,y = l.split(" => ")
      @rules[x] = y
    end
  end

  def show
    pots.join
  end

  def sumit
    pots.each_with_index.select{|v,i| v == '#'}.map{ |v,i| i+offset }.reduce(:+)
  end

  def tick
    curr_pots = pots.dup 
    local_min = 999999999 
    local_max = -999999999
    # byebug if offset == -1 && diff == 26
    (-4..diff+4).each do |ii|
      # byebug if offset == -1 && diff == 26# && ii == -1
      if change(ii+8-offset, curr_pots) == "#"
        # byebug
        local_min = [local_min, ii].min 
        local_max = [local_max, ii].max 
      end
    end
    # byebug if offset == -1 && diff == 26

    @diff = local_max - local_min
    @offset = local_min

    recalibrate
    puts show
    [offset, offset+diff]
  end

  def recalibrate
    # @pots = (["."]*8) + @pots[offset+8..offset+8+diff] + (["."]*8)
    min_i, max_i = pots.each_with_index.select{|v,i| v == "#"}.map{|v, i| i}.minmax 
    @pots = (["."]*8) + @pots[min_i..max_i] + (["."]*8)

  end

  def change(pot_num, curr_pots)
    premise = curr_pots.values_at(pot_num-2,pot_num-1,pot_num,pot_num+1,pot_num+2).join
    if rules.key? premise 
      @pots[pot_num] = rules[premise]
    else
      @pots[pot_num] = '.'
    end
    @pots[pot_num]
  end

  def part1
    20.times{tick}
    sumit
  end

  # def period?
  #   # init_state = pots.dup.values
  #   cnt = 0
  #   loop do 
  #     tick 
  #     cnt +=1

  #     su = pots.select{|k,v| v == '#'}.keys.join("-")
  #     if seen.values.include? su 
  #       puts [seen.invert[su], cnt] 
  #       break
  #     end
      
  #     @seen[cnt] = su
  #   end
  #   cnt
  # end

  # def part2

  # end

end