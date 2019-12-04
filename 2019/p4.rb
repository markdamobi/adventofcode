
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
   n = n.to_s
  found = nil

  (1..n.size-2).each do |i|
    if((n[i] == n[i-1]))
      if(n[i] != n[i+1])
        return true
      else
        found = false
      end
    end
  end
  found
end

def adjacent_same2?(n)
  n = n.to_s
  cnt = 1
  curr = n[0]
  n.chars[1..-1].each do |i|
    if(i != curr)
      return true if cnt == 2
      curr = i
      cnt = 1
    else
      cnt += 1
    end
  end
  return true if cnt == 2
  nil
end

##bad code... so bad...