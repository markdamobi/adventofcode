require './helper'
$sleep = Hash.new({})

## TODO: REFACTOR. this is quite messy.
def part1()

  info = []
  data = []
  input = File.readlines("p4_input.txt").map{ |i| i.strip}
  input.each do |ii|
    data << extract(ii) 
  end

  data.sort_by!{|a,b| a}
  sleep_record = process(data)
  $guards = Hash.new { |h, k| h[k] = [] }
  sleep_record.values.each do |v|
    $guards[v[:guard]] += v[:sleep]
  end

  max_sleep_guard = $guards.find{ |k,v| v.size == $guards.values.map(&:size).max }
  id = max_sleep_guard[0][1..-1].to_i
  frequency = freq(max_sleep_guard[1])
  frequency.find{ |k,v| v == frequency.values.max }[0] * id
end 

def process(data)
  output = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = [] } }
  guard = nil
  data.each_with_index do |line, i|
    d, action = line
    if action.start_with? "#"
      guard = action
    elsif action == "sleep"
      mth_day = d.strftime("%m-%d")
      output[mth_day][:guard] = guard
      sleep_minute = d.minute
      wake_minute = data[i+1][0].minute
      output[mth_day][:sleep] += (sleep_minute...wake_minute).to_a
    end
  end
  output
end


def extract(input)
  arr = []
  if md = /\[(.*)\] Guard (#\d*).*/.match(input) || /\[(.*)\] .*(sleep).*/.match(input) || /\[(.*)\] .*(wake).*/.match(input)
    arr << DateTime.parse(md[1])
    arr << md[2]
  end
  arr
end

###TODO: Refactor. 
def part2()
  info = []
  data = []
  input = File.readlines("p4_input.txt").map{ |i| i.strip}
  input.each do |ii|
    data << extract(ii) 
  end

  data.sort_by!{|a,b| a}
  sleep_record = process(data)
  guards = Hash.new { |h, k| h[k] = [] }
  sleep_record.values.each do |v|
    guards[v[:guard]] += v[:sleep]
  end

  guards = guards.map{|k,v| [k, freq(v).find{ |a,b| b == freq(v).values.max }]}.to_h
  max_guard = guards.find{|k,v| v[1] == guards.values.map{|v|v[1] }.max}
  max_guard[1][0] * max_guard[0][1..-1].to_i
end