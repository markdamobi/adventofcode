
def read_arr(file)
  File.readlines(file).map{|l| l.strip.split(" ")}
end

def run
  input = read_arr('2017/p4_input.txt')
  input.select{|i| i == i.uniq}.count
end
