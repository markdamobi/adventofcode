require 'active_support/all'
require 'byebug'

class KnotHash
  attr_reader :curr_pos, :skip_size, :list, :lengths

  def initialize(lengths, list=(0..255).to_a)
    @curr_pos = 0
    @lengths = lengths
    @skip_size = 0
    @list = list
  end

  def knot(length)
    items = (curr_pos...curr_pos+length).map{|i| list[i%list.length]}
    items_rev = items.reverse
    (curr_pos...curr_pos+length).each{|i| @list[i%list.length] = items_rev[i-curr_pos]}
    @curr_pos = (curr_pos + length + skip_size)%list.length
    @skip_size += 1
  end

  def knot_all
    lengths.each{|l| knot(l)}
  end
end

def run1
  # k = KnotHash.new([3,4,1,5], (0..4).to_a)
  k = KnotHash.new("225,171,131,2,35,5,0,13,1,246,54,97,255,98,254,110".split(",").map(&:to_i))
  k.knot_all
  p k.list
  k.list[0] * k.list[1]
end
