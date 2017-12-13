def checksum(matrix)
  matrix.reduce(0){|acc,row| acc + (row.max-row.min)}
end

def read_matrix(file)
  File.readlines(file).map{|l| l.strip.split("\t").map(&:to_i)}
end

## assume irb is called from root.
def run1
  checksum(read_matrix('2017/p2.txt'))
end
