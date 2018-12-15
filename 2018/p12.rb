require './helper'

class Plant
  def initialize(filename="p12_input.txt", round=20)
    @filename = filename
    read_file(round)
    @seen = {}
  end

  attr_reader :filename, :rules ,:pots, :prev_pots, :seen

  def read_file(round)
    lines = File.readlines(filename).map{ |i| i.chomp}
    @rules = {}
    @pots = {}
    init_state = lines[0].split(": ")[1].split("")

    (-round..-1).each{|n| @pots[n] = '.'}
    (0...init_state.size).each{|n| @pots[n] = init_state[n]}
    (init_state.size..init_state.size+round).each{|n| @pots[n] = '.'}
    @prev_pots = pots.dup
    lines[2..-1].each do |l|
      x,y = l.split(" => ")
      @rules[x] = y
    end
  end

  def show
    pots.sort_by{|k,v|k}.map{|k,v| v}.join
  end

  def sumit
    pots.select{|k,v| v == '#'}.keys.reduce(:+)
  end

  def tick
    curr_pots = pots.dup  
    pots.keys.each do |k|
      change(k, curr_pots)
    end
  end

  def change(pot_num, curr_pots)
    premise = curr_pots.values_at(pot_num-2,pot_num-1,pot_num,pot_num+1,pot_num+2).map{|x| x.nil? ? '.' : x }.join
    if rules.key? premise 
      @pots[pot_num] = rules[premise]
    else
      @pots[pot_num] = '.'
    end
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