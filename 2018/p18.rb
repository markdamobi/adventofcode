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
					byebug
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

end