require_relative "../lib/base"

def part1(basename = 'p1.txt')
  nums = File.readlines(File.join(INPUT_DIR, basename)).map { |i| i.strip.to_i }

  x, y = nums.combination(2).find{ |x, y| x + y == 2020 }
  x * y
end

def part2(basename = 'p1.txt')
  nums = File.readlines(File.join(INPUT_DIR, basename)).map { |i| i.strip.to_i }

  x, y, z = nums.combination(3).find { |x, y, z| x + y + z == 2020 }
  x * y * z
end
