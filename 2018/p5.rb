require './helper'


def part1()
  input = File.read("p5_input.txt").strip
  react(input)
end 


def react(input)
  input = input.chars
  while true
    changed = false
    (0..input.length-1).each_cons(2) do |a,b|
      if destroy?(input[a],input[b])
        changed |= true
        input[a] = nil
        input[b] = nil
      end
    end
    input = input.compact
    break if !changed 
  end
  input.size
end

def destroy?(c1,c2)
  return false if c1.nil? || c2.nil?
  return true if c1.downcase == c2.downcase && c1 != c2
  false
end 


## this takes about 1 minute to run. I might have to improve my react method. 
def part2()
  original_input = File.read("p5_input.txt").strip
  ('a'..'z').map{ |l| react(original_input.gsub(/[#{l},#{l.upcase}]/, "")) }.min
end