
def valid?(n)
  adjacent_same?(n) && !decreasing?(n)
end

def valid2?(n)
  adjacent_same2?(n) && !decreasing?(n)
end

def decreasing?(n)
  n = n.to_s
  (1..n.size-1).find{|i| n[i] < n[i-1]}
end

def adjacent_same?(n)
  n = n.to_s
  (1..n.size-1).find{|i| n[i] == n[i-1]}
end

def adjacent_same2?(n)
  n.to_s.chars.chunk{|s| s}.any?{|a, b| b.size == 2 }
end