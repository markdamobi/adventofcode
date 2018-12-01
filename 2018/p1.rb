def solve()
  File.readlines("p1_input.txt").map{|i| i.strip.to_i}.reduce(:+)
end