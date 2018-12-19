require './helper'
class Lumber 
	def initialize(filename="p18_input.txt")
		@filename = filename
		readfile

	end 

	attr_reader :filename, :grid, :row_lim, :col_lim

	def readfile
		@grid = []
		File.readlines(filename).each do |line|
			@grid << line.strip.split("")
		end
		@row_lim = grid.size 
		@col_lim = grid[0].size
	end

	def show
		puts state
	end

	def state 
		grid.map{|row| row.join}.join("\n")
	end

	def tick
		prev_grid = grid.deep_dup 
		(0...row_lim).each do |row|
			(0...col_lim).each do |col|
				process(row,col, prev_grid)
			end
		end
		state
	end

	def tickn(n)
		n.times{tick}
	end


	def process(row, col, prev_grid) 
		val = prev_grid[row][col]
		ns = neighbors(row, col)

		open_acre = 0 
		tree  = 0 
		lumberyard = 0 

		ns.each do |r,c| 
			begin 
				open_acre += 1 if open?(r,c, prev_grid)
				tree += 1      if tree?(r,c, prev_grid)
				lumberyard +=1 if lumberyard?(r,c, prev_grid)
			rescue 
				# byebug
			end
		end

		val = "|" if open?(row, col, prev_grid)       && tree >= 3
		val = "#" if tree?(row, col, prev_grid)       && lumberyard >= 3
		val = "." if lumberyard?(row, col, prev_grid) && !(lumberyard > 0 && tree > 0)

		@grid[row][col] = val 

	end

	def tree?(row, col, ggrid);       ggrid[row][col] == "|"; end
	def open?(row, col, ggrid);       ggrid[row][col] == "."; end
	def lumberyard?(row, col, ggrid); ggrid[row][col] == "#"; end

	def neighbors(row, col)
		ns = []
		(row-1..row+1).each do |r|
			(col-1..col+1).each do |c|
				begin
					ns << [r,c] unless (r == row && c == col) || !(r.between?(0,row_lim-1)) || !(c.between?(0,col_lim-1))
				rescue 

				end
			end
		end
	ns
	end

	def num_resources
		tree = 0 
		open_acre = 0 
		lumberyard = 0 
		(0...row_lim).each do |row|
			(0...col_lim).each do |col|
				begin
					open_acre += 1 if open?(row,col, grid)
					tree += 1      if tree?(row,col, grid)
					lumberyard +=1 if lumberyard?(row,col, grid)
				rescue StandardError => e
					# byebug
				end
			end
		end
		tree * lumberyard
	end

	def part1(n=10)
		tickn n
		resources = num_resources
		puts resources 
		resources
	end

	def get_period
		seen = {}
		count = 0 
		init_state = state.deep_dup
		loop do 
			tick 
			count += 1
			x = state
			if seen.key? x
				puts "#{seen[x]} -> #{count}"
				break
			end
			seen[state] = count 
		end
	end

	#### using the get_period method, it turns out that 551 -> 579. this means that the process starts to cycle. 
	#### and it has a period of 579 - 551 = 28. so (1000,000,000 - 551)%28 = 1. this means that we only need 552 iterations for 1 bil. 

end