require './helper'

def cell_power(x, y, s_num)
	# return 1
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


def part2(s_num, grid_size)
	max = [0,0,0]
	max_v = -999999999
	(1..grid_size).each do |x|
		puts "x: #{x}. max: #{max.to_s}. max: #{max_v}"
		(1..grid_size).each do |y|
			l_max_v, l_max_sq = get_max(x,y,grid_size,s_num)
			if l_max_v > max_v 
				max_v = l_max_v
				max_sq = l_max_sq
				max = [x,y,max_sq]
			end
		end
	end
	p max
	max
end

def get_max(x,y,grid_size,s_num)
	limit = grid_size - [x,y].max + 1
	max_v = cell_power(x,y,s_num)
	max_sq = 1 
	local_max = max_v 

	(2..limit).each do |sq|
		(x..x+sq-2).each{|i| local_max += cell_power(i,y+sq-1,s_num)}
		(y..y+sq-2).each{|j| local_max += cell_power(x+sq-1,j,s_num)}
		local_max += cell_power(x+sq-1, y+sq-1, s_num)
		if local_max > max_v
			max_v, max_sq = local_max, sq
		end
	end
	[max_v, max_sq]
end

## runs in about 4 minis
# Benchmark.bm{|bm| bm.report {part1(7347,300)}}