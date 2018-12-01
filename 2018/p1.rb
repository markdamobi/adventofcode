require './helper'

def part1()
  File.readlines("p1_input.txt").map{ |i| i.strip.to_i }.reduce(:+)
end

def part2()
  seen = Set.new([])
  frequency = 0
  File.readlines("p1_input.txt").map{ |i| i.strip.to_i }.cycle do |i|
    frequency += i 
    break if seen.include? frequency
    seen.add(frequency)
  end
  frequency
end