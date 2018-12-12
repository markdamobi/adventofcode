require './helper'

def cell_power(x, y, s_num)
	rack_id = x+10
	p_level = rack_id * y
	p_level += s_num 
	p_level = p_level * rack_id
	p_level = (p_level / 100)%10
	p_level -= 5 
end

def get_n_power(x,y,n,s_num)
	total = 0
	(x...x+n).each do |i|
		(y...y+n).each do |j|
			total += cell_power(i,j,s_num)
		end
	end
	total
end

def part1(s_num)
	n = 3
	max = [0,0]
	max_v = -999999999
	(1..300-n+1).each do |x|
		(1..300-n+1).each do |y|
			temp_max = get_n_power(x,y,n,s_num)
			if temp_max > max_v
				max = [x,y]
				max_v = temp_max
			end
		end
	end
	p max
	max
end

def part1(s_num, grid_size)
	n = 3
	max = [0,0,0]
	max_v = -999999999
	(1..grid_size).each do |size|
		puts "square size: #{size}"
		(1..grid_size-n+1).each do |x|
			(1..grid_size-n+1).each do |y|
				temp_max = get_n_power(x,y,size,s_num)
				if temp_max > max_v
					max = [x,y,size]
					max_v = temp_max
				end
			end
		end
	end
	p max
	max
end

# Benchmark.bm{|bm| bm.report {part1(7347,300)}}