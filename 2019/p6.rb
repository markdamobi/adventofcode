
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
  graph = Graph.new(orbits)
  graph.dijkstra("YOU", "SAN")
end

## pretty basic implementation of dikstra. really just bfs and counting steps.
## can cleanup later. okay for now.
## visited should probably be called "processed".
class Graph
  def initialize(orbits)
    @orbits = orbits
    @nodes = (orbits.keys + orbits.values).uniq
    @distances = {}

    @nodes.each do |n|
      @distances[n] = 9999999999
    end
  end

  attr_reader :orbits, :nodes, :distances

  def dijkstra(source, destination)
    visited = {}
    @distances[source] = 0

    while(visited.keys.size < nodes.size)
      min_node = get_min_node(visited)
      visited[min_node] = true

      if min_node == destination
        puts (distances[destination] - 2)
        return
      end

      neighbors = get_neighbors(min_node, visited)

      neighbors.each do |nb|
        if(distances[nb] > (distances[min_node] + 1))
          distances[nb] = distances[min_node] + 1
        end
      end
    end
  end

  ##unprocessed neighbors
  def get_neighbors(n, visited)
    neighbors = []
    orbits.each do |k,v|
      neighbors << v if (k == n && !visited[v])
      neighbors << k if (v == n && !visited[k])
    end
    neighbors
  end

  def get_min_node(visited)
    unvisited_nodes = nodes.select{|n| !visited[n] }
    unvisited_nodes.min_by{|n| distances[n]}
  end

end
