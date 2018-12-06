require './helper'

#### could use a little refactoring. initially had a problem figuring out the inifinite ones, but I figured that if I increased my grid by a bit in all directions,
#### then the infinite ones will increase, while the finite ones should hopefully stay the same. that worked for me..
def part1()
  input = File.readlines("p6_input.txt").map{ |i| i.strip}
  # input = File.readlines("p6_test.txt").map{ |i| i.strip}
  orig_points = input.map{|l| l.split(", ").map(&:to_i)}
  orig_hash = {}
  orig_points.each do |x,y|
    orig_hash[[x,y]] = true
  end
  x, y = orig_points.map{|pair| pair[0]}.max, orig_points.map{|pair| pair[1]}.max

  closests_1 = {}
  (0..x).each do |x_coord|
    (0..y).each do |y_coord|
      closests_1[[x_coord, y_coord]] = get_closest(x_coord, y_coord, orig_points)
    end
  end
  frequency1 = freq(closests_1.values)   

  closests_2 = {}
  (0-10..x+10).each do |x_coord|
    (0-10..y+10).each do |y_coord|
      closests_2[[x_coord, y_coord]] = get_closest(x_coord, y_coord, orig_points)
    end
  end
  frequency2 = freq(closests_2.values) 

  true_freq = frequency1.select{|k,v| frequency2[k] == v}
  true_freq.find{|k,v| v == true_freq.values.max}[1]
end

def get_closest(x,y, pts)
  distances = pts.map{|xc, yc| (xc-x).abs + (yc-y).abs}
  least = distances.min 
  shortest = distances.each_with_index.to_a.select{|dist, ind| dist == least}
  return nil if shortest.size > 1
  shortest[0][1]
end

def get_total(x,y, pts)
  distances = pts.map{|xc, yc| (xc-x).abs + (yc-y).abs}.reduce(:+)
end

def part2()
  input = File.readlines("p6_input.txt").map{ |i| i.strip}
  orig_points = input.map{|l| l.split(", ").map(&:to_i)}
  orig_hash = {}
  orig_points.each do |x,y|
    orig_hash[[x,y]] = true
  end
  x, y = orig_points.map{|pair| pair[0]}.max, orig_points.map{|pair| pair[1]}.max
  totals = {}
  (0..x).each do |x_coord|
    (0..y).each do |y_coord|
      totals[[x_coord, y_coord]] = get_total(x_coord, y_coord, orig_points)
    end
  end
  totals.select{|x,y| y < 10000}.size 
end