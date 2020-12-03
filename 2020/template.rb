require './base'

def part1(file: 'p3_test.txt')
  input = read_file(file: file)
  #process input
end

def part2(file: 'p3_test.txt')
  input = read_file(file: file)
end

### Helpers
def read_file(file:)
  File.readlines(file).map { |line| parse(line) }
end

def parse(line)
  line = line.chomp.strip

  # extra manipulation for each line.
  # eg. line.split(/\W+/) ## split on Non-word characters(i.e returns "words").
end
