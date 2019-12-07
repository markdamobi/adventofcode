require './graph'
require 'byebug'

def run1(file: 'p6.txt')
  orbits = get_orbits(file)
  tot = countDirect(orbits) + countAllIndirects(orbits)
  tot
end

def get_orbits(file)
  data = File.readlines(file).map{|l| l.chomp.strip}
  orbits = {}
  data.each do |d|
    x, y = d.split(")")
    orbits[y] = x
  end
  orbits
end

def countDirect(orbits)
  orbits.keys.size
end

def countIndirect(orbits, key)
  if key == "COM"
    return 0
  elsif orbits[key] == "COM"
    return 0
  else
    return 1 + countIndirect(orbits, orbits[key])
  end
end

def countAllIndirects(orbits)
  su = 0
  orbits.keys.each do |k|
    su += countIndirect(orbits, k)
  end
  su
end

def run2(file: "p6.txt")
  orbits = get_orbits(file)
  graph = Graph.new(edges: orbits.entries, directed: false)
  distances = graph.dijkstra(source: "YOU", destination: "SAN")
  distances["SAN"] - 2
end
