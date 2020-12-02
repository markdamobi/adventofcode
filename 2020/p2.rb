require './base'

def part1(file: 'p2_test.txt')
  lines = File.readlines(file).map { |l| parse(l) }
  lines.count { |l| valid?(*l) }
end

def parse(line)
  range, letter, password = line.split(" ")
  minc, maxc = range.split("-").map(&:to_i)
  letter = letter[0..-2]
  [minc, maxc, letter, password]
end

def valid?(minc, maxc, letter, password)
  lsize = password.count(letter)
  lsize >= minc && lsize <= maxc
end

def valid2?(minc, maxc, letter, password)
  (password[minc - 1] == letter && password[maxc - 1] != letter) || (password[minc - 1] != letter && password[maxc - 1] == letter)
end

def part2(file: 'p2_test.txt')
  lines = File.readlines(file).map { |l| parse(l) }
  lines.count { |l| valid2?(*l) }
end
