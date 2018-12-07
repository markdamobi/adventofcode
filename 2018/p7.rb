require './helper'

$rules = Hash.new { |h, k| h[k] = [] }

def part1()
  input = File.readlines("p7_input.txt").map{ |i| i.strip}
  # input = File.readlines("p7_test.txt").map{ |i| i.strip}

  input.each do |rule|
    parse_rule(rule)
  end

  get_sequence.join
  
end

def parse_rule(line)
  md = /Step (.).*step (.).*/.match line
  a,b = md[1], md[2]
  $rules[b] += [a]
end

def get_sequence
  start_opts = $rules.values.flatten.uniq.select{|k| !$rules.keys.include?(k)}
  start = start_opts.sort.first 
  start_opts.delete start 
  seq = [start]


  available = start_opts | get_available(start, seq)

  while !available.empty?
    next_l = available.sort.first
    seq << next_l 
    available.delete next_l
    available |= get_available(next_l, seq)
  end
  seq

end

def get_available(item, seq)
  $rules.select{|k,v| (v - seq - [item]).empty? && k != item}.keys - seq
end