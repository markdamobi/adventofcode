require './helper'
def part1()
  input = File.readlines("p2_input.txt").map{ |i| i.strip}
  twos = 0
  threes = 0
  input.each do |word|
    fc = fq(word)
    twos += 1 if fc.values.include? 2
    threes += 1 if fc.values.include? 3
  end
  twos * threes
end 

def fq(str)
  h = Hash.new(0)
  str.chars.each do |c|
    h[c] += 1
  end
  h
end

def compare_str(s1, s2)
  s1c = s1.chars 
  s2c = s2.chars 
  s1c.zip(s2c).count{|a,b| a != b}
end

def eliminate_diff(a,b)
  ans = a.chars 
  ans.reject.with_index {|c, i| (0..b.size).select{|i| a[i] != b[i]}.include? i}.join
end

def part2()
  input = File.readlines("p2_input.txt").map{ |i| i.strip}
  eliminate_diff *input.combination(2).select{|a,b| compare_str(a,b) == 1}[0]
end