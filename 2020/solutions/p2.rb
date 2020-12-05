require_relative "../lib/base"

def part1(basename = 'p2_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
  input.count { |l| valid?(*l) }
end

def read_file(file)
  File.readlines(file).map { |line| parse(line) }
end

def parse(line)
  line.chomp.strip.split(/\W+/).map{ |word| Integer(word) rescue word }
end

def valid?(minc, maxc, letter, password)
  lsize = password.count(letter)
  lsize >= minc && lsize <= maxc
end

def valid2?(minc, maxc, letter, password)
  (password[minc - 1] == letter) ^ (password[maxc - 1] == letter)
end

def part2(basename = 'p2_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
  input.count { |l| valid2?(*l) }
end

# Running
# puts part1(file: 'p2.txt')
# puts part2(file: 'p2.txt')