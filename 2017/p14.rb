require 'active_support/all'
require 'byebug'

class KnotHash
  attr_reader :curr_pos, :skip_size, :list, :lengths, :dense_hash

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

  def knot_all(n=1)
    n.times{lengths.each{|l| knot(l)}}
  end

  def dense
    @dense_hash = list.each_slice(16).map{|l| l.reduce(:^)}
  end

  def hexify
    dense_hash.map{|n| "%02x" % n}.join("")
  end

  def bitstr
    hex_str = hexify
    hex_str.chars.map{|num| num.hex.to_s(2).rjust(num.size*4, '0')}.join("")
  end


  # def knot_for_row(row)
  #   bitstr
  # end
end

def run1
  num_used = 0
  128.times do |r|
    k = KnotHash.new("ljoxqyyw-#{r}".split("").map(&:ord) + [17, 31, 73, 47, 23])
    # k = KnotHash.new("flqrgnkx-#{r}".split("").map(&:ord) + [17, 31, 73, 47, 23])
    k.knot_all(64)
    k.dense
    num_used += k.bitstr.count("1")
  end
  num_used
end

def run2
  k = KnotHash.new("225,171,131,2,35,5,0,13,1,246,54,97,255,98,254,110".split("").map(&:ord) + [17, 31, 73, 47, 23])
  k.knot_all(64)
  k.dense
  k.hexify
end
