


def run1
  data = File.read('p2.txt').split(",").map(&:to_i)
  part1(data)[0]
end

def run2
  data = File.read('p2.txt').split(",").map(&:to_i)
  part2(data)
end


def part1(list)
  list[1] = 12
  list[2] = 2

  ops = ["", "+", "*"]

  op = list[0]
  idx = 0
  while(op != 99)
    x = list[idx+1]
    y = list[idx+2]
    target = list[idx+3]

    result = eval("#{list[x]} #{ops[op]} #{list[y]}")
    list[target] = result

    idx += 4
    op = list[idx]
  end
  list
end



def part2(list)
  orig_list = list.dup
  ops = ["", "+", "*"]

  # this code is ugly.
  (0..50).to_a.permutation(2).to_a.each do |i, j|
    list = orig_list.dup
    list[1] = i
    list[2] = j

    op = list[0]
    idx = 0
    while(op != 99)
      x = list[idx+1]
      y = list[idx+2]
      target = list[idx+3]

      result = eval("#{list[x]} #{ops[op]} #{list[y]}")
      list[target] = result

      if result == 19690720
        puts "#{i} #{j}"
        puts "#{ 100 * i + j }"
        return
      end
      idx += 4
      op = list[idx]
    end
  end
end






# raw = <<~Data
# testing
# stragegy
# Data