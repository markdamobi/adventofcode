require './helper'
$grid = Hash.new(0)

def part1()
  input = File.readlines("p3_input.txt").map{ |i| i.strip}
  input.each do |inp| 
    claim = Claim.new(*extract(inp))
    claim.fill_grid 
  end
  $grid.values.count{|v| v > 1}
end 

def extract(input)
  input.split(/[#,\s,:,x,@]/).reject{|x| x == ""}
end


class Claim
  def initialize(id, left, top, width, length)
    @id = id 
    @left = left.to_i
    @top = top.to_i
    @length = length.to_i 
    @width = width.to_i
  end
  attr_reader :id, :left, :top, :width, :length

  def fill_grid
    start = [left, top]
    (left...left+width).each do |x|
      (top...top+length).each do |y|
        $grid[[x,y]] += 1
      end
    end
  end

  def overlap?
    start = [left, top]
    (left...left+width).each do |x|
      (top...top+length).each do |y|
        return true if $grid[[x,y]] > 1
      end
    end
    false
  end
end


def part2()
  input = File.readlines("p3_input.txt").map{ |i| i.strip}
  claims = []
  input.each do |inp| 
    claim = Claim.new(*extract(inp))
    claims << claim
    claim.fill_grid 
  end
  no_overlap = claims.find{ |c| !c.overlap? }
end