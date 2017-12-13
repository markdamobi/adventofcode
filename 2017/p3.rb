## get integer in bottom corner with coordinate (-n,-n)
def bottom_corner(n)
  if n == 0
    return 1
  elsif n == 1
    return 7
  else

    a_prev = 7
    a_curr = 0
    2.upto(n) do |i|
      a_curr = a_prev + 6 + (8 * (i-1))
      a_prev = a_curr
    end

  end
  a_curr
end
