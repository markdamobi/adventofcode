
def read_arr(file)
  File.readlines(file).map{|l| l.strip.split(" ")}
end

def run1
  input = read_arr('2017/p4_input.txt')
  input.select{|i| i == i.uniq}.count
end

def run2
  input = read_arr('2017/p4_input.txt')
  input.select{|i| i.count == i.map{|w| w.chars.sort.join("")}.uniq.count }.count
end
