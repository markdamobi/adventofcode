require './base'

def part1(file = 'p5_test.txt')
  input = read_file(file)

  input.map{ |seat| get_id(seat) }.max
end

def part2(file = 'p5_test.txt')
  input = read_file(file)
  ids = input.map{ |seat| get_id(seat) }.sort

  ids.each_cons(2).find { |x, y| x < y-1 }
end

def get_id(seat)
  get_row(seat) * 8 + get_col(seat)
end

def get_row(seat)
  row_dir = seat[0..6]
  left = 0
  right = 127

  row_dir.chars.each do |d|
    mid = (left + right) / 2
    if d == "F"
      right = mid
    elsif d == "B"
      left = mid + 1
    end
  end

  [left, right].min
end

def get_col(seat)
  col_dir = seat[7..-1]
  left = 0
  right = 7

  col_dir.chars.each do |d|
    mid = (left + right) / 2
    if d == "L"
      right = mid
    elsif d == "R"
      left = mid + 1
    end
  end

  [left, right].min
end

### Helpers
def read_file(file)
  File.readlines(file).map { |line| parse(line) }
end

def parse(line)
  line = line.chomp.strip
end
