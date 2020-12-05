require_relative "../lib/base"

def part1(basename = 'px_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
  #process input
end

def part2(basename = 'px_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))
end

### Helpers
def read_file(file)
  File.readlines(file).map { |line| parse(line) }
end

def parse(line)
  line = line.chomp.strip

  # extra manipulation for each line.
  # eg. line.split(/\W+/) ## split on Non-word characters(i.e returns "words").
end
