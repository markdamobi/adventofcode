require_relative "../lib/base"

def part1(basename = 'p6_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
  input.map { |answers| answers.chars.uniq.size }.reduce(:+)
end

def part2(basename = 'p6_test.txt')
  input = read_file2(File.join(INPUT_DIR, basename))
  input.map { |answers| ("a".."z").count { |l| answers.map(&:chars).flatten.join.count(l) == answers.size } }.sum
end

### Helpers
def read_file(file)
  File.read(file).split("\n\n").map{|x| x.delete("\n")}
end

def read_file2(file)
  File.read(file).split("\n\n").map{|x| x.split("\n")}
end