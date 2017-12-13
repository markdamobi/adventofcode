def checksum(matrix)
  matrix.reduce(0){|acc,row| acc + (row.max-row.min)}
end

def evendiv(matrix)
  matrix.reduce([]){|acc,row| acc << row.permutation(2).to_a.uniq.find{|x,y| (x%y == 0)}}.reduce(0){|acc, pair| acc + pair[0]/pair[1]}
end

def read_matrix(file)
  File.readlines(file).map{|l| l.strip.split("\t").map(&:to_i)}
end

## assume irb is called from root.
def run1
  checksum(read_matrix('2017/p2.txt'))
end

def run2
  evendiv(read_matrix('2017/p2.txt'))
end
