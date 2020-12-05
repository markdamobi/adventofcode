require_relative "../lib/base"

def part1(basename = 'p4_test.txt')
  input = read_file(File.join(INPUT_DIR, basename))

  input.count do |password|
    Password.new(password).valid?
  end
end

class Password
  attr_reader :password
  REQUIRED = %w(byr iyr eyr hgt hcl ecl pid)
  OPTIONAL = %w(cid)


  def initialize(password)
    @password = password
  end

  def valid?
    REQUIRED.all? do |r|
      password.include?("#{r}:")
    end
  end
end


class Password2
  attr_reader :password
  REQUIRED = %w(byr iyr eyr hgt hcl ecl pid)
  OPTIONAL = %w(cid)


  def initialize(password)
    @password = password
  end

  def byr?
    val = password["byr"].to_i
    password.include?("byr") && val.in?(1920..2002)
  end
  def iyr?
    val = password["iyr"].to_i
    password.include?("iyr") && val.in?(2010..2020)
  end
  def eyr?
    val = password["eyr"].to_i
    password.include?("eyr") && val.in?(2020..2030)
  end

  def hgt?
    val = password["hgt"]
    return nil unless val.present?
    num, unit = val.split(/(in)|(cm)/)
    num = num.to_i

    ((unit == "cm") && num.in?(150..193)) || ((unit == "in") && num.in?(59..76))
  end

  def hcl?
    val = password["hcl"]
    val.present? && val.match(/\#[a|b|c|d|e|f|\d]{6}$/)
  end

  def ecl?
    password["ecl"].in?(%w(amb blu brn gry grn hzl oth))
  end

  def pid?
    val = password["pid"]

    val.present? && val.match(/^\d{9}$/)
  end

  def valid2?
    byr? && iyr? && eyr? && hgt? && hcl? && ecl? && pid?
  end
end

def part2(basename = 'p4_test_valid.txt')
  input = read_file2(File.join(INPUT_DIR, basename))
  binding.pry
  input.count do |password|
    pwd = Password2.new(password)
    pwd.valid2?
  end
end

### Helpers
def read_file(file)
  File.read(file).split("\n\n")
end

def read_file2(file)
  File.read(file).split("\n\n").map{|l| l.split(/\s+/).map{|x| x.split(":") }.to_h}
end

def parse(line)
  line = line.chomp.strip
end
