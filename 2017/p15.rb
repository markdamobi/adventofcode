def read_arr(file)
  File.readlines(file).map{|l| l.strip.split(" ")}
end

class Gen
  attr_reader :a, :b, :afactor, :bfactor, :pr
  def initialize(a1, b1)
    @a = a1
    @b = b1
    @afactor = 16807
    @bfactor = 48271
    @pr = 2147483647
  end

  def bina
    x = "%016b" % a
    return x[-16..-1] if x.length > 16
    x
  end

  def binb
    x = "%016b" % b
    return x[-16..-1] if x.length > 16
    x
  end

  def set_next
    @a = (a * afactor)% pr
    @b = (b * bfactor)% pr
    [a,b]
  end

  def set_next2
    loop do
      @a = (a * afactor)% pr
      break if a%4 == 0
    end

    loop do
      @b = (b * bfactor)% pr
      break if b%8 == 0
    end
    [a,b]
  end

  # def last16
  #
  # end
end

def run
  # arr = read_arr('2017/p15_input.txt')
  g = Gen.new(618,814)

  c = 0
  c+= 1 if g.bina == g.binb
  (40000000-1).times do
    g.set_next
    if g.bina == g.binb
      c += 1
    end
  end
  c
end

def run2
  g = Gen.new(618,814)

  c = 0
  c+= 1 if g.bina == g.binb
  (5000000-1).times do
    g.set_next2
    if g.bina == g.binb
      c += 1
    end
  end
  c
end



# def testrun
#   g = Gen.new(65,8921)
#
#   c = 0
#   c+= 1 if g.bina == g.binb
#   (5-1).times do
#     p g.set_next
#     p [g.bina, g.binb]
#     if g.bina == g.binb
#       c += 1
#     end
#   end
#   c
# end
